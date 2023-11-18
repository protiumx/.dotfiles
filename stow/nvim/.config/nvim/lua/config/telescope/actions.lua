local action_set = require('telescope.actions.set')
local action_state = require('telescope.actions.state')

local state = require('config.state')

local M = {}

local get_selected_entries = function(current_picker)
  local selected = {}
  local selections = current_picker:get_multi_selection()
  if vim.tbl_isempty(selections) then
    table.insert(selected, action_state.get_selected_entry())
  else
    for _, selection in ipairs(selections) do
      table.insert(selected, selection)
    end
  end

  return selected
end

function M.toggle_buffer_mark(prompt_bufnr)
  local current_picker = action_state.get_current_picker(prompt_bufnr)
  local entries = get_selected_entries(current_picker)
  for _, entry in ipairs(entries) do
    local mark = '󰤱'
    local old = ' '
    if not state.toggle_buffer_mark(entry.bufnr) then
      old = '󰤱'
      mark = ' '
    end

    local row = current_picker:get_row(entry.index)
    local start = #current_picker.selection_caret

    vim.api.nvim_buf_set_text(current_picker.results_bufnr, row, start, row, start + #old, { mark })
  end
end

function M.select_window(prompt_bufnr)
  local picker = action_state.get_current_picker(prompt_bufnr)
  picker.get_selection_window = function(_, _)
    local picked_window_id = require('window-picker').pick_window({
      filter_rules = {
        autoselect_one = false,
      },
    }) or vim.api.nvim_get_current_win()
    -- Unbind after using so next instance of the picker acts normally
    picker.get_selection_window = nil
    return picked_window_id
  end

  return action_set.edit(prompt_bufnr, 'edit')
end

return M
