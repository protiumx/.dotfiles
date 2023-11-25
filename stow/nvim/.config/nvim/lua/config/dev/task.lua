local notify = require('config.dev.notify')

local ns = vim.api.nvim_create_namespace('_dev_')

---@alias View
---| '"notify"'
---| '"popup"'

---@class Task
---@field cmd string[]
---@field file string
---@field jobid number
---@field output number|View
---@field name string
---@field runner function
local Task = {}

---@param file string
---@param cmd string[]
---@param output number|View Output buffer number or view name
---@param name string
---@return Task
function Task:new(file, cmd, output, name)
  return setmetatable({
    cmd = cmd,
    file = file,
    jobid = -1,
    name = name,
    output = output,
    runner = nil,
  }, { __index = self })
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
  self:_set_title()

  return nil
end

function Task:destroy()
  if self.jobid ~= -1 then
    vim.fn.jobstop(self.jobid)
  end

  self.output = nil
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
      notify.error('Failed to start job: ' .. self.cmd[1])
    end
  end
end

function Task:run()
  self:_loading()
  self.runner()
end

function Task:_loading()
  if type(self.output) == 'string' then
    return
  end

  self:_write_buffer({ '...' })
end

function Task:_output(content)
  if not content then
    return
  end

  content = vim.tbl_filter(function(line)
    return line:gsub('%s+', '') ~= ''
  end, content)

  if #content == 0 then
    content = { '[No output]' }
  end

  local text = ''
  if type(content) == 'table' then
    text = table.concat(content, '\n')
  end

  if self.output == 'notify' then
    notify.info(text)
    return
  end

  if self.output == 'popup' then
    return
  end

  self:_write_buffer(content)
end

function Task:_set_title()
  vim.api.nvim_buf_set_lines(self.output, 0, -1, false, { self.name, '' })
  vim.api.nvim_buf_set_extmark(
    self.output,
    ns,
    0,
    0,
    { end_row = 1, hl_group = 'DevOutputBufferTitle', hl_eol = true }
  )
end

---@param content string[]
function Task:_write_buffer(content)
  if not vim.api.nvim_buf_is_valid(self.output) then
    return
  end

  -- skip title and empty line
  vim.api.nvim_buf_set_lines(self.output, 2, -1, false, content)
end

return Task
