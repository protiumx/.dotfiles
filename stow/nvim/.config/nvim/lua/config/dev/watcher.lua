local notify = require('config.dev.notify')
local Task = require('config.dev.task')

local FILETYPE = 'dev-watcher'
local Autocmd_group = vim.api.nvim_create_augroup('dev-watcher', { clear = true })

---@class Watcher
---@field autocmd_id number
---@field pattern string
---@field tasks Task[]
local Watcher = {}

---@param pattern string
function Watcher:new(pattern)
  local t = setmetatable({
    autocmd_id = -1,
    pattern = pattern,
    tasks = {},
  }, { __index = self })

  t:_set_events()

  return t
end

---@param cmd string[]
---@param out string
function Watcher:add_task(cmd, out)
  if self:_has_task_with_cmd(cmd) then
    notify.error(
      string.format(
        'command "%s" already set for pattern "%s"',
        table.concat(cmd, ' '),
        self.pattern
      )
    )
    return
  end

  ---@type string|number
  local output = out
  if out == 'vs' or out == 'sp' then
    local _, buffer = self:_create_buffer(out == 'vs')
    output = buffer
  end

  local task_name =
    string.format('dev[%s]#%d: %s', self.pattern, #self.tasks, table.concat(cmd, ' '))
  local task = Task:new(self.pattern, cmd, output, task_name)
  local error = task:setup()
  if error then
    notify.error('invalid task: ' .. error)
    task:destroy()
    return
  end

  table.insert(self.tasks, task)
  task:run()
end

---@param task_id number
function Watcher:remove_task(task_id)
  local task = table.remove(self.tasks, task_id) --[[@as Task]]
  if not task then
    return
  end

  task:destroy()
end

function Watcher:destroy()
  vim.api.nvim_del_autocmd(self.autocmd_id)
  for _, task in ipairs(self.tasks) do
    (task --[[@as Task]]):destroy()
  end

  self.tasks = nil
end

---@param cmd string[]
function Watcher:_has_task_with_cmd(cmd)
  local command_id = table.concat(cmd, '')
  for _, t in ipairs(self.tasks) do
    if command_id == table.concat(t.cmd, '') then
      return true
    end
  end

  return false
end

---@param vertical boolean
---@return number, number
function Watcher:_create_buffer(vertical)
  local buffer = vim.api.nvim_create_buf(true, true)
  local title = string.format('dev[%s]#%d', self.pattern, #self.tasks)
  vim.api.nvim_buf_set_option(buffer, 'filetype', FILETYPE)
  vim.api.nvim_buf_set_name(buffer, title)
  vim.api.nvim_buf_set_keymap(buffer, 'n', 'q', '<cmd>q<CR>', { silent = true })

  vim.cmd.split({ mods = { vertical = vertical } })
  local winid = vim.api.nvim_get_current_win()
  vim.cmd('wincmd p') -- immediately switch back to last window

  vim.api.nvim_win_set_buf(winid, buffer)
  vim.api.nvim_win_set_option(winid, 'number', false)
  vim.api.nvim_win_set_option(winid, 'relativenumber', false)
  vim.api.nvim_win_set_option(winid, 'colorcolumn', '')
  vim.api.nvim_win_set_option(winid, 'signcolumn', 'no')
  vim.api.nvim_win_set_option(winid, 'spell', false)

  return winid, buffer
end

function Watcher:_run_tasks()
  for _, task in ipairs(self.tasks) do
    vim.schedule(function()
      (task --[[@as Task]]):run()
    end)
  end
end

function Watcher:_set_events()
  vim.api.nvim_create_autocmd('BufWritePost', {
    group = Autocmd_group,
    pattern = self.pattern,
    callback = function()
      self:_run_tasks()
    end,
  })
end

return Watcher
