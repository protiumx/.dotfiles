local colors = require('config.colors')

-- require('gruvbox').setup({
--   undercurl = true,
--   underline = true,
--   bold = true,
--   palette_overrides = {
--     dark0 = colors.background,
--     dark1 = colors.background,
--   },
--   overrides = {
--     NotifyINFOIcon = { link = 'GruvboxFg1' },
--   },
--   dim_inactive = true,
--   transparent_mode = false,
-- })
--

require("tokyonight").setup({
  transparent = true,
})

-- vim.cmd('colorscheme gruvbox')
vim.cmd('colorscheme tokyonight-storm')

colors.load()

-- vim.cmd [[colorscheme photon]]
