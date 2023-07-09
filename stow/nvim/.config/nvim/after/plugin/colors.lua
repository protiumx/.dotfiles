local colors = require('config.colors')

require('gruvbox').setup({
  undercurl = true,
  underline = true,
  bold = true,
  palette_overrides = {
    dark0 = colors.background,
    dark1 = colors.background,
  },
  dim_inactive = false,
  transparent_mode = false,
})

vim.cmd('colorscheme gruvbox')

colors.load()

-- vim.cmd [[colorscheme photon]]
