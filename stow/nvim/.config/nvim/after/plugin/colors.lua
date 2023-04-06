local colors = require('config.colors')
local themes = require('config.themes')

-- vim.cmd("colorscheme PaperColor")
-- vim.g['PaperColor_Theme_Options'] = {
--   theme = {
--     default = { dark = { override = { color07 = { colors.foreground, '' } } } }
--   }
-- }

-- themes.load()

require("gruvbox").setup({
  undercurl = true,
  underline = true,
  bold = true,
  palette_overrides = {
    dark0 = colors.background,
    dark1 = colors.background,
  },
  overrides = {
    Pmenu = { bg = colors.dark_grey },
  },
  dim_inactive = true,
  transparent_mode = false,
})
vim.cmd("colorscheme gruvbox")

themes.setup()
themes.load_overrides()
