local action_set = require('telescope.actions.set')
local action_state = require('telescope.actions.state')

local state = require('config.state')

local M = {}

function M.toggle_buffer_mark(prompt_bufnr)
  local current_picker = action_state.get_current_picker(prompt_bufnr)
  local entry = action_state.get_selected_entry()
  local mark = '󰤱'
  local old = ' '
  if not state.toggle_buffer_mark(entry.bufnr) then
    old = '󰤱'
    mark = ' '
  end

  local row = current_picker:get_selection_row()
  -- stylua: ignore
  local col =
    current_picker:is_multi_selected(entry) and #current_picker.multi_icon
    or #current_picker.selection_caret
  vim.api.nvim_buf_set_text(current_picker.results_bufnr, row, col, row, col + #old, { mark })
end

function M.select_window(prompt_bufnr)
  local picker = action_state.get_current_picker(prompt_bufnr)
  picker.get_selection_window = function(_, _)
    local picked_window_id = require('window-picker').pick_window({
      filter_rules = {
        autoselect_one = false,
      },
    })

    picked_window_id = picked_window_id or vim.api.nvim_get_current_win()
    -- Unbind after using so next instance of the picker acts normally
    picker.get_selection_window = nil
    return picked_window_id
  end

  return action_set.edit(prompt_bufnr, 'edit')
end

return M
