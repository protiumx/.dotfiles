local notify = require('config.dev.notify')

---@alias View
---| '"notify"'
---| '"popup"'

---@class Task
---@field cmd string[]
---@field file string
---@field jobid number
---@field output number|View
---@field runner function
local Task = {}

---@param file string
---@param cmd string[]
---@param output number|View Output buffer number or view name
---@return Task
function Task:new(file, cmd, output)
  return setmetatable({
    cmd = cmd,
    file = file,
    jobid = -1,
    output = output,
    runner = nil,
  }, { __index = self })
end

---Validates the command is a valid Lua module or OS executable
---@return string|nil
function Task:validate()
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

---@param content string[]
function Task:_write_buffer(content)
  if not vim.api.nvim_buf_is_valid(self.output) then
    return
  end

  vim.api.nvim_buf_set_lines(self.output, 0, -1, false, content)
end

return Task
