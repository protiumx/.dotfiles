local notify = require('config.dev.notify')
local ui = require('config.ui')

local FILETYPE = 'dev-watcher'
local ns = vim.api.nvim_create_namespace('dev-ns')
local TaskAugroup = vim.api.nvim_create_augroup('dev-augroup', { clear = true })

---@class Task
---@field buffer number
---@field jobid number
---@field name string
---@field popup table|nil
---@field on_terminated_callback function
---@field opts WatchOptions
---@field runner fun(file:string)
---@field winid number
local Task = {}

---@type Output[]
local WriteableOutputs = { 'vs', 'sp', 'popup' }

---@param name string
---@param opts WatchOptions
---@return Task
function Task:new(name, opts)
  return setmetatable({
    buffer = -1,
    jobid = -1,
    name = name,
    on_terminated_callback = nil,
    opts = opts,
    popup = nil,
    runner = nil,
    winid = -1,
  }, { __index = self })
end

---Validates the command is a valid Lua module or OS executable
---@return string|nil
function Task:setup()
  local fn, error = self:_build_runner()
  if fn == nil or error ~= nil then
    return string.format('failed to setup task: %s', error)
  end

  self.runner = fn

  if self.opts.output == 'vs' or self.opts.output == 'sp' then
    self:_setup_split()
  elseif self.opts.output == 'popup' then
    self:_setup_popup()
  end

  return nil
end

---Register a callback when a task is terminated.
---Tasks are terminated if the output buffer (split or popup) is deleted.
---@param callback function
function Task:on_terminated(callback)
  self.on_terminated_callback = callback
end

function Task:_stop_job()
  if self.jobid ~= -1 then
    vim.fn.jobstop(self.jobid)
  end
end

function Task:destroy()
  self:_stop_job()

  if self.popup then
    self.popup:unmount()
    self.popup = nil
  end

  if self.buffer ~= -1 and vim.api.nvim_buf_is_valid(self.buffer) then
    vim.api.nvim_buf_delete(self.buffer, { force = true })
  end
end

---Evaluates the cmd into a function
---@return function?,string?
function Task:_build_runner()
  local command = self.opts.cmd[1]
  if command == 'lua' then
    local _, error = loadstring(self.opts.raw_cmd)
    if error ~= nil then
      return nil, error
    end

    return function(file)
      local lua_string = self.opts.raw_cmd:gsub('${file}', file)
      local fn, _ = loadstring(lua_string) --[[@as function]]
      self:_handle_cmd_output(fn())
    end
  end

  if vim.startswith(command, ':') then
    if vim.fn.exists(command) ~= 2 then
      return nil, 'invalid {expr}'
    end

    return function(file)
      local expr = self.opts.raw_cmd:gsub('${file}', file)
      self:_handle_cmd_output(vim.cmd(expr))
    end
  end

  -- OS commands
  if vim.fn.executable(command) == 0 then
    return nil, 'not an executable command: "' .. command .. '"'
  end

  return function(file)
    local cmd = vim.list_slice(self.opts.cmd)
    if self.opts.raw_cmd:find('${file}') then
      for i, _ in ipairs(cmd) do
        cmd[i] = cmd[i]:gsub('${file}', file)
      end
    end

    self.jobid = vim.fn.jobstart(cmd, {
      cwd = vim.loop.cwd(),
      stderr_buffered = true,
      stdout_bufered = true,
      on_stdout = function(_, content)
        self:_handle_cmd_output(content)
      end,
      on_stderr = function(_, content)
        self:_handle_cmd_output(content)
      end,
    })

    if self.jobid == -1 then
      notify.error('failed to start job: ' .. self.opts.cmd[1])
    end
  end
end

---@param file string
function Task:run(file)
  self:_write_output({ '...' })
  self.runner(file)
end

function Task:_handle_cmd_output(content)
  if not content then
    return
  end

  if not vim.tbl_islist(content) then
    content = { vim.inspect(content) }
  elseif type(content) == 'string' then
    content = { content }
  end

  -- filter out trailing line break
  content = vim.tbl_filter(function(line)
    return line:gsub('%s+', '') ~= ''
  end, content)

  if #content == 0 then
    return
  end

  if self.opts.output == 'notify' then
    local text = '[dev] ' .. self.name .. '\n'
    if type(content) == 'table' then
      text = text .. table.concat(content, '\n')
    end

    vim.notify(text)
    return
  end

  self:_write_output(content)

  if self.popup ~= nil then
    self.popup:show()
  end
end

---@param buffer number
function Task:_set_buffer_title(buffer)
  vim.api.nvim_buf_set_lines(buffer, 0, 1, false, { self.name, '' })
  vim.api.nvim_buf_set_extmark(
    buffer,
    ns,
    0,
    0,
    { end_row = 1, hl_group = 'DevOutputBufferTitle', hl_eol = true }
  )
end

---@param content string[]
function Task:_write_output(content)
  if not vim.tbl_contains(WriteableOutputs, self.opts.output) then
    return
  end

  local buffer = self.popup and self.popup.bufnr or self.buffer
  -- skip title and empty line
  vim.api.nvim_buf_set_lines(buffer, 2, -1, false, content)
end

function Task:_setup_popup()
  self.popup = ui.popup()
  self:_set_buffer_title(self.popup.bufnr)
end

function Task:_setup_split()
  local buffer = vim.api.nvim_create_buf(true, true)
  vim.api.nvim_buf_set_option(buffer, 'filetype', FILETYPE)
  vim.api.nvim_buf_set_option(buffer, 'buftype', 'nofile')
  vim.api.nvim_buf_set_name(buffer, self.name)
  vim.api.nvim_buf_set_keymap(buffer, 'n', 'q', '<cmd>q<CR>', { silent = true })

  vim.cmd.split({ mods = { vertical = self.opts.output == 'vs' } })
  local winid = vim.api.nvim_get_current_win()
  vim.cmd('wincmd p') -- immediately switch back to last window

  vim.api.nvim_win_set_buf(winid, buffer)
  vim.api.nvim_win_set_option(winid, 'number', false)
  vim.api.nvim_win_set_option(winid, 'relativenumber', false)
  vim.api.nvim_win_set_option(winid, 'colorcolumn', '')
  vim.api.nvim_win_set_option(winid, 'signcolumn', 'no')
  vim.api.nvim_win_set_option(winid, 'spell', false)

  -- Terminate the task if the output buffer is deleted
  vim.api.nvim_create_autocmd('BufDelete', {
    buffer = buffer,
    group = TaskAugroup,
    once = true,
    callback = function()
      self:_stop_job()
      if self.on_terminated_callback then
        self.on_terminated_callback()
      end
      notify.info(string.format('Task %s terminated', self.name))
    end,
  })

  self:_set_buffer_title(buffer)

  self.buffer = buffer
  self.winid = winid
end

return Task
