local Watcher = require('config.dev.watcher')
local notify = require('config.dev.notify')

---@type table<string, Watcher>
local State = {}

---@class WatchConfig
---@field pattern string
---@field cmd string[]
---@field out string

local defaults = {
  cmd = {},
  pattern = '',
  out = 'vs',
}

local MAX_TASKS = 3
local M = {}

--- Watches a file and runs a command when the file is saved
---@param config WatchConfig
function M.watch(config)
  config = vim.tbl_extend('force', defaults, config or {}) --[[@as WatchConfig]]
  assert(#config.cmd > 0, 'Invalid command')
  assert(config.pattern ~= '', 'Invalid watch pattern')

  local watcher = State[config.pattern] ---@as Watcher
  if not watcher then
    watcher = Watcher:new(config.pattern)
    State[config.pattern] = watcher
  end

  if vim.tbl_count(watcher.tasks) >= MAX_TASKS then
    notify.warn(string.format('pattern "%s" reached tasks limit [%d]', config.pattern, MAX_TASKS))
    return
  end

  watcher:add_task(config.cmd, config.out)
end

---@param pattern string
---@param task_id number|nil
function M.unwatch(pattern, task_id)
  local watcher = State[pattern] --[[@as Watcher]]
  if not watcher then
    notify.warn('no watchers found for: ' .. pattern)
    return
  end

  if task_id ~= nil then
    watcher:remove_task(task_id)
    notify.info(string.format('task #%d removed from %s watcher', task_id, pattern))
    return
  end

  watcher:destroy()
  State[pattern] = nil

  vim.notify('removed watcher for ' .. pattern)
end

return M
