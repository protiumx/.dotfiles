local notify = require('config.dev.notify')
local ui = require('config.ui')

local FILETYPE = 'dev-watcher'
local ns = vim.api.nvim_create_namespace('dev-ns')

---@alias View
---| '"notify"'
---| '"popup"'

---@class Task
---@field buffer number
---@field jobid number
---@field name string
---@field popup table|nil
---@field opts WatchOptions
---@field runner function
---@field winid number
local Task = {}

---@param name string
---@param opts WatchOptions
---@return Task
function Task:new(name, opts)
  return setmetatable({
    buffer = -1,
    jobid = -1,
    name = name,
    opts = opts,
    popup = nil,
    runner = nil,
    winid = -1,
  }, { __index = self })
end

---Validates the command is a valid Lua module or OS executable
---@return string|nil
function Task:setup()
  local command = self.opts.cmd[1]
  if command == 'neotest' then
    local ok, _ = pcall(require, 'neotest')
    if not ok then
      return 'neotest not available'
    end
  end

  if vim.fn.executable(command) == 0 then
    return 'not an executable command: "' .. command .. '"'
  end

  self.runner = self:_get_runner()

  if self.opts.output == 'vs' or self.opts.output == 'sp' then
    self:_setup_buffer_output()
    self:_set_buffer_title(self.buffer)
  elseif self.opts.output == 'popup' then
    self.popup = ui.popup()
    self:_set_buffer_title(self.popup.bufnr)
  end

  return nil
end

function Task:destroy()
  if self.jobid ~= -1 then
    vim.fn.jobstop(self.jobid)
  end

  if self.popup then
    self.popup:unmount()
    self.popup = nil
  end

  if self.buffer ~= -1 and vim.api.nvim_buf_is_valid(self.buffer) then
    vim.api.nvim_buf_delete(self.buffer, { force = true })
  end
end

---Evaluates the cmd into a function
---@return function
function Task:_get_runner()
  local command = self.opts.cmd[1]
  if command == 'neotest' then
    return function()
      require('neotest').run.run(self.opts.params or vim.fn.expand('%'))
    end
  end

  -- OS commands
  return function()
    self.jobid = vim.fn.jobstart(self.opts.cmd, {
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

function Task:run()
  if self.buffer ~= -1 then
    self:_write_output({ '...' })
  end
  self.runner()
end

function Task:_handle_cmd_output(content)
  if not content then
    return
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
    if not self.popup._.mounted then
      self.popup:mount()
      vim.api.nvim_win_set_option(self.popup.border.winid, 'winblend', ui.winblend)
    end
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
  local buffer = self.popup and self.popup.bufnr or self.buffer
  -- skip title and empty line
  vim.api.nvim_buf_set_lines(buffer, 2, -1, false, content)
end

function Task:_setup_buffer_output()
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

  self.buffer = buffer
  self.winid = winid
end

return Task
