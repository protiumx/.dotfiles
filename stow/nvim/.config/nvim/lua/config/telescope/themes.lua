local themes = require('telescope.themes')

local M = {
  ---@param opts table | nil
  get_dropdown = function(opts)
    local dropdown = themes.get_dropdown({
      hidden = true,
      winblend = 20,
      no_ignore = true,
      previewer = false,
      prompt_title = '',
      show_line = false,
      borderchars = {
        prompt = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
        results = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
        preview = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
      },
      preview_title = '',
      results_title = '',
      layout_config = { prompt_position = 'top' },
    })
    return vim.tbl_extend('force', dropdown, opts or {})
  end,
}

return M
