local themes = require('telescope.themes')
local ui = require('config.ui')

local M = {
  base = {
    winblend = ui.winblend,
    show_line = false,
    borderchars = {
      prompt = { ' ' },
      results = { ' ' },
      preview = { ' ' },
    },
    prompt_title = '',
  },
}
---@param opts table | nil
M.get_dropdown = function(opts)
  opts = vim.tbl_extend('force', M.base, opts or {})
  local dropdown = themes.get_dropdown({
    previewer = false,
    preview_title = '',
    results_title = '',
  })
  return vim.tbl_extend('force', dropdown, opts)
end
---
---@param opts table | nil
M.get_ivy = function(opts)
  opts = vim.tbl_extend('force', M.base, opts or {})
  return themes.get_ivy(opts)
end

return M
