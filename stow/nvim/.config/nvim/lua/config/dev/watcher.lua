local notify = require('config.dev.notify')
local Task = require('config.dev.task')

local Autocmd_group = vim.api.nvim_create_augroup('dev-watcher', { clear = true })

---@class Watcher
---@field autocmd_id number
---@field pattern string
---@field tasks Task[]
local Watcher = {}

---@alias Output
---| '"vs"'
---| '"sp"'
---| '"notify"'
---| '"popup"'

---@class WatchOptions
---@field cmd string[]
---@field raw_cmd string
---@field params? string
---@field pattern string
---@field output? Output

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

---@param opts WatchOptions
function Watcher:add_task(opts)
  opts.raw_cmd = table.concat(opts.cmd, ' ')
  if self:_has_task_with_cmd(opts.raw_cmd) then
    notify.error(
      string.format('command "%s" already set for pattern "%s"', opts.raw_cmd, self.pattern)
    )
    return
  end

  local task_name = string.format('dev[%s]#%d: %s', self.pattern, #self.tasks, opts.raw_cmd)
  local task = Task:new(task_name, opts)
  local error = task:setup()
  if error then
    notify.error('failed to setup task: ' .. error)
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
    notify.error('invalid task id ' .. task_id)
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

---@param raw_cmd string
function Watcher:_has_task_with_cmd(raw_cmd)
  for _, t in ipairs(self.tasks) do
    if raw_cmd == t.opts.raw_cmd then
      return true
    end
  end

  return false
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
