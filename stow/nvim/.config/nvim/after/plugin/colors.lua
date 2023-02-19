local colors = require('config.colors')
local themes = require('config.themes')

vim.cmd("colorscheme PaperColor")
vim.g['PaperColor_Theme_Options'] = {
  theme = {
    default = { dark = { override = { color07 = { colors.foreground, '' } } } }
  }
}

themes.load()
