local notify = require('config.dev.notify')
local Task = require('config.dev.task')

local WatcherAugroup = vim.api.nvim_create_augroup('dev_watcher', { clear = true })

---@class Watcher
---@field autocmd_id number
---@field file string
---@field tasks Task[]
local Watcher = {}

---@param file string
function Watcher:new(file)
  local t = setmetatable({
    autocmd_id = -1,
    file = file,
    tasks = {},
  }, { __index = self })

  t:_watch()

  return t
end

---@param cmd string[]
---@param out string
function Watcher:add_task(cmd, out)
  if self:_has_cmd(cmd) then
    notify.error(string.format('"%s" already running for file', table.concat(cmd, ' ')))
    return
  end

  ---@type string|number
  local output = out
  if out == 'vs' or out == 'sp' then
    local _, buffer = self:_create_buffer(out == 'vs')
    output = buffer
  end

  local task = Task:new(
    self.file,
    cmd,
    output,
    string.format('dev[%s]#%d: %s', self.file, #self.tasks, table.concat(cmd, ' '))
  )
  local error = task:setup()
  if error then
    notify.error('Invalid task: ' .. error)
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
function Watcher:_has_cmd(cmd)
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
  local title = string.format('dev[%s]#%d', self.file, #self.tasks)
  vim.api.nvim_buf_set_option(buffer, 'filetype', '_dev_')
  vim.api.nvim_buf_set_name(buffer, title)
  vim.api.nvim_buf_set_keymap(buffer, 'n', 'q', '<cmd>q<CR>', { silent = true })

  vim.cmd.split({ mods = { vertical = vertical } })
  local winid = vim.api.nvim_get_current_win()
  vim.cmd('wincmd w') -- immediately switch back to last window

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

function Watcher:_watch()
  vim.api.nvim_create_autocmd('BufWritePost', {
    group = WatcherAugroup,
    pattern = self.file,
    callback = function()
      self:_run_tasks()
    end,
  })
end

return Watcher
