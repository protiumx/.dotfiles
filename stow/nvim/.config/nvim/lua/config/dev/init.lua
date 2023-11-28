local ui = require('config.ui')
local Watcher = require('config.dev.watcher')
local notify = require('config.dev.notify')

---@type table<string, Watcher>
local Watchers = {}

---@type WatchOptions
local defaults = {
  cmd = {},
  cwd = '',
  raw_cmd = '',
  pattern = '%',
  output = 'vs',
}

local MAX_TASKS = 3
local Manager = {
  popup = nil,
  entries = {},
  lines = {},
}

vim.api.nvim_create_autocmd('VimLeavePre', {
  pattern = '*',
  callback = function()
    for _, watcher in pairs(Watchers) do
      watcher:destroy()
    end
  end,
})

--- Watches a file and runs a command when the file is saved
---@param opts WatchOptions
function Manager.watch(opts)
  opts = vim.tbl_extend('force', defaults, opts) --[[@as WatchOptions]]
  opts.pattern = vim.fn.expand(opts.pattern)
  if opts.cwd == '' then
    opts.cwd = vim.loop.cwd()
  else
    opts.cwd = vim.fn.expand(opts.cwd)
  end

  assert(#opts.cmd > 0, 'Invalid command')
  assert(opts.pattern ~= '', 'Invalid watch pattern')

  if opts.pattern:find('watch%[.*%]') then
    notify.error('cannot add watcher to a watcher buffer')
    return
  end

  for i, c in ipairs(opts.cmd) do
    opts.cmd[i] = vim.fn.expand(c)
  end

  local watcher = Watchers[opts.pattern] ---@as Watcher
  if not watcher then
    watcher = Watcher:new(opts.pattern)
    Watchers[opts.pattern] = watcher
  end

  if vim.tbl_count(watcher.tasks) >= MAX_TASKS then
    notify.warn(string.format('pattern "%s" reached tasks limit [%d]', opts.pattern, MAX_TASKS))
    return
  end

  watcher:add_task(opts)
end

---@param pattern string
---@param task_id number|nil
function Manager.unwatch(pattern, task_id)
  local watcher = Watchers[pattern] --[[@as Watcher]]
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
  Watchers[pattern] = nil

  vim.notify('removed watcher for ' .. pattern)
end

function Manager.inspect()
  if vim.tbl_count(Watchers) == 0 then
    notify.info('No watchers')
    return
  end

  Manager._setup_popup()

  Manager.entries = {}
  Manager.lines = {}

  Manager:_load_content()
  vim.api.nvim_buf_set_lines(Manager.popup.bufnr, 0, -1, false, Manager.lines)

  Manager.popup:show()
end

function Manager:_load_content()
  if vim.tbl_count(Watchers) == 0 then
    return
  end

  local entries = {}
  local lines = {}
  local index = 0
  for key, watcher in pairs(Watchers) do
    table.insert(entries, { watcher = key, summary = 'Watcher #' .. index })
    table.insert(lines, string.format('#%d [%s]', index, key))

    if #watcher.tasks == 0 then
      table.insert(lines, '  [No tasks]')
      table.insert(entries, nil)
    else
      for j, task in ipairs(watcher.tasks) do
        table.insert(entries, { watcher = key, summary = 'Task #' .. (j - 1), task_id = j })
        table.insert(
          lines,
          string.format('  #%d cmd="%s" output=%s', j - 1, task.opts.raw_cmd, task.opts.output)
        )
      end
    end

    if index < vim.tbl_count(Watchers) - 1 then
      table.insert(lines, '')
    end

    index = index + 1
  end

  Manager.entries = entries
  Manager.lines = lines
end

function Manager._setup_popup()
  if Manager.popup then
    return
  end

  Manager.popup = ui.popup()
  Manager.popup:map('n', 'd', function()
    Manager._handle_item_delete(false)
  end)

  Manager.popup:map('n', 'D', function()
    Manager._handle_item_delete(true)
  end)

  Manager.popup:map('n', 'x', function()
    Manager._handle_delete_all(false)
  end)

  Manager.popup:map('n', 'X', function()
    Manager._handle_delete_all(false)
  end)
end

---@param force boolean
function Manager._handle_delete_all(force)
  local total = vim.tbl_count(Watchers)
  local proceed = force or Manager.confirm(string.format('Remove all %d watchers? [y/n]', total))
  if not proceed then
    return
  end

  for _, watcher in pairs(Watchers) do
    watcher:destroy()
  end

  notify.info(string.format('Removed %d watcher', total))
  Manager.popup:hide()
end

---@param force boolean
function Manager._handle_item_delete(force)
  local row = vim.api.nvim_win_get_cursor(0)[1]
  if row > #Manager.entries then
    return
  end

  local entry = Manager.entries[row]
  if not entry then
    return
  end

  local watcher = Watchers[entry.watcher]
  if force or Manager.confirm(string.format('Remove %s? [y/n]: ', entry.summary)) then
    if entry.task_id then
      watcher:remove_task(entry.task_id)
    else
      watcher:destroy()
      Watchers[entry.watcher] = nil
    end

    notify.info(entry.summary .. ' removed')
    Manager.popup:hide()
  end
end

---@param prompt string
---@param value? string
function Manager.confirm(prompt, value)
  value = value or ''
  local confirmation = vim.fn.input(prompt, value)
  confirmation = string.lower(confirmation)
  if string.len(confirmation) == 0 then
    return false
  end

  return confirmation == 'y'
end

return Manager
