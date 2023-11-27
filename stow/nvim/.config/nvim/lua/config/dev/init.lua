local ui = require('config.ui')
local Watcher = require('config.dev.watcher')
local notify = require('config.dev.notify')

---@type table<string, Watcher>
local State = {}

---@type WatchOptions
local defaults = {
  cmd = {},
  pattern = '',
  output = 'vs',
}

local MAX_TASKS = 3
local M = {
  popup = nil,
  entries = {},
  lines = {},
}

--- Watches a file and runs a command when the file is saved
---@param opts WatchOptions
function M.watch(opts)
  opts = vim.tbl_extend('force', defaults, opts or {}) --[[@as WatchOptions]]
  assert(#opts.cmd > 0, 'Invalid command')
  assert(opts.pattern ~= '', 'Invalid watch pattern')

  local watcher = State[opts.pattern] ---@as Watcher
  if not watcher then
    watcher = Watcher:new(opts.pattern)
    State[opts.pattern] = watcher
  end

  if vim.tbl_count(watcher.tasks) >= MAX_TASKS then
    notify.warn(string.format('pattern "%s" reached tasks limit [%d]', opts.pattern, MAX_TASKS))
    return
  end

  watcher:add_task(opts)
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

function M.inspect()
  M._setup_popup()

  M._load_content(State)
  vim.api.nvim_buf_set_lines(M.popup.bufnr, 0, -1, false, M.lines)

  if not M.popup._.mounted then
    M.popup:mount()
    vim.api.nvim_win_set_option(M.popup.border.winid, 'winblend', ui.winblend)
  end

  M.popup:show()
end

function M:_load_content()
  if vim.tbl_count(State) == 0 then
    return
  end

  local entries = {}
  local lines = {}
  local index = 0
  for key, watcher in pairs(State) do
    table.insert(entries, { watcher = key, summary = 'Watcher #' .. index })
    table.insert(lines, string.format('#%d [%s]', index, key))

    for j, task in ipairs(watcher.tasks) do
      table.insert(entries, { watcher = key, summary = 'Task #' .. (j - 1), task_id = j })
      table.insert(
        lines,
        string.format('  #%d cmd="%s" output=%s', j - 1, task.opts.raw_cmd, task.opts.output)
      )
    end

    if index < vim.tbl_count(State) - 1 then
      table.insert(lines, '')
    end
    index = index + 1
  end

  M.entries = entries
  M.lines = lines
end

function M._setup_popup()
  if M.popup then
    return
  end

  M.popup = ui.popup()
  M.popup:map('n', 'd', function()
    M._handle_item_delete(false)
  end)

  M.popup:map('n', 'D', function()
    M._handle_item_delete(true)
  end)
end

---@param force boolean
function M._handle_item_delete(force)
  local row = vim.api.nvim_win_get_cursor(0)[1]
  if row > #M.entries then
    return
  end

  local entry = M.entries[row]
  local watcher = State[entry.watcher]
  if force or M.confirm(string.format('Remove %s? [y/n]: ', entry.summary)) then
    if entry.task_id then
      watcher:remove_task(entry.task_id)
    else
      watcher:destroy()
      State[entry.watcher] = nil
    end

    notify.info(entry.summary .. ' removed')
    M.popup:hide()
  end
end

---@param prompt string
---@param value? string
function M.confirm(prompt, value)
  value = value or ''
  local confirmation = vim.fn.input(prompt, value)
  confirmation = string.lower(confirmation)
  if string.len(confirmation) == 0 then
    return false
  end

  return confirmation == 'y'
end

return M
