local themes = require('telescope.themes')

local M = {}
---@param opts table | nil
M.get_dropdown = function(opts)
  local dropdown = themes.get_dropdown(opts or {})
  return vim.tbl_extend('force', dropdown, {
    previewer = false,
    prompt_title = '',
    preview_title = '',
    results_title = '',
  })
end

return M
