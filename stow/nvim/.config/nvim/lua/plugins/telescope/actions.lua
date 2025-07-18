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

return M
