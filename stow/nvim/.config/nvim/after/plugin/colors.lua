local colors = require('config.colors')

require('gruvbox').setup({
  undercurl = true,
  underline = true,
  bold = true,
  contrast = '',
  palette_overrides = {
    dark0 = colors.background,
    dark1 = colors.background,
  },
  dim_inactive = false,
  transparent_mode = true,
})

-- vim.g.sonokai_style = 'default'
-- vim.g.sonokai_better_performance = 1
-- vim.g.sonokai_menu_selection_background = 'green'
-- vim.g.sonokai_transparent_background = 2

vim.cmd('colorscheme gruvbox')

colors.load()
