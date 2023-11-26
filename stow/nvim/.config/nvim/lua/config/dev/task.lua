local Popup = require('nui.popup')
local event = require('nui.utils.autocmd').event

local notify = require('config.dev.notify')

local ns = vim.api.nvim_create_namespace('_dev_')

local popup_config = {
  enter = true,
  focusable = true,
  position = '50%',
  size = {
    width = '40%',
    height = '60%',
  },
  relative = 'editor',
  border = {
    padding = {
      top = 1,
      bottom = 1,
      left = 1,
      right = 1,
    },
    style = 'none',
  },
  buf_options = {
    modifiable = true,
    readonly = false,
  },
  win_options = {
    winblend = 20,
    winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder',
  },
}

---@alias View
---| '"notify"'
---| '"popup"'

---@class Task
---@field buffer number
---@field cmd string[]
---@field file string
---@field jobid number
---@field name string
---@field popup table|nil
---@field output number|View
---@field runner function
local Task = {}

---@param file string
---@param cmd string[]
---@param output number|View Output buffer number or view name
---@param name string
---@return Task
function Task:new(file, cmd, output, name)
  local t = setmetatable({
    cmd = cmd,
    file = file,
    jobid = -1,
    name = name,
    popup = nil,
    output = output,
    buffer = -1,
    runner = nil,
  }, { __index = self })

  if type(output) == 'number' then
    t.buffer = output
  elseif output == 'popup' then
    t.popup = t._create_popup()
  end

  return t
end

---Validates the command is a valid Lua module or OS executable
---@return string|nil
function Task:setup()
  local command = self.cmd[1]
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
  if self.output ~= 'notify' then
    self:_set_buffer_title()
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
end

function Task._create_popup()
  local popup = Popup(popup_config)
  popup:map('n', 'q', function()
    popup:hide()
  end)
  popup:on(event.BufLeave, function()
    popup:hide()
  end)

  return popup
end

---Evaluates the cmd into a function
---@return function
function Task:_get_runner()
  local command = self.cmd[1]
  if command == 'neotest' then
    return function()
      require('neotest').run.run(self.file)
    end
  end

  -- OS commands
  return function()
    self.jobid = vim.fn.jobstart(self.cmd, {
      cwd = vim.loop.cwd(),
      stderr_buffered = true,
      stdout_bufered = true,
      on_stdout = function(_, content)
        self:_output(content)
      end,
      on_stderr = function(_, content)
        self:_output(content)
      end,
    })

    if self.jobid == -1 then
      notify.error('failed to start job: ' .. self.cmd[1])
    end
  end
end

function Task:run()
  if self.output ~= 'notify' and self.output ~= 'popup' then
    self:_write_buffer({ '...' })
  end
  self.runner()
end

function Task:_output(content)
  if not content then
    return
  end

  content = vim.tbl_filter(function(line)
    return line:gsub('%s+', '') ~= ''
  end, content)

  if #content == 0 then
    return
  end

  if self.output == 'notify' then
    local text = '[dev] ' .. self.name .. '\n'
    if type(content) == 'table' then
      text = text .. table.concat(content, '\n')
    end

    vim.notify(text)
    return
  end

  self:_write_buffer(content)

  if self.output == 'popup' then
    if not self.popup._.mounted then
      self.popup:mount()
      vim.api.nvim_win_set_option(self.popup.border.winid, 'winblend', 20)
    end
    self.popup:show()
  end
end

function Task:_set_buffer_title()
  local buffer = self.popup and self.popup.bufnr or self.buffer
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
function Task:_write_buffer(content)
  if self.output == 'notify' then
    return
  end
  local buffer = self.popup and self.popup.bufnr or self.buffer
  -- skip title and empty line
  vim.api.nvim_buf_set_lines(buffer, 2, -1, false, content)
end

return Task
