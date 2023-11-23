local themes = require('telescope.themes')

local M = {}
---@param opts table | nil
M.get_dropdown = function(opts)
  local dropdown = themes.get_dropdown(opts or {})
  return vim.tbl_extend('force', dropdown, {
    previewer = false,
    winblend = 20,
    show_line = false,
    borderchars = {
      prompt = { ' ' },
      results = { ' ' },
      preview = { ' ' },
    },
    prompt_title = '',
    preview_title = '',
    results_title = '',
  })
end

return M
