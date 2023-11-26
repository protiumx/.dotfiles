local ui = require('config.ui')
local themes = require('telescope.themes')

local M = {}
---@param opts table | nil
M.get_dropdown = function(opts)
  opts = opts or {}
  local dropdown = themes.get_dropdown({
    previewer = false,
    winblend = ui.winblend,
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
  return vim.tbl_extend('force', dropdown, opts)
end

return M
