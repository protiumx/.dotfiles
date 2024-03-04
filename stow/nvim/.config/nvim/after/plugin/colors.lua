local colors = require('config.colors')

-- require('gruvbox').setup({
--   undercurl = true,
--   underline = true,
--   bold = true,
--   contrast = '',
--   palette_overrides = {
--     dark0 = colors.background,
--     dark1 = colors.background,
--   },
--   dim_inactive = false,
--   transparent_mode = true,
-- })

-- vim.g.sonokai_style = 'default'
-- vim.g.sonokai_better_performance = 1
-- vim.g.sonokai_menu_selection_background = 'green'
-- vim.g.sonokai_transparent_background = 2

vim.cmd('colorscheme oxocarbon')

colors.load()

-- vim.api.nvim_set_hl(0, "RedRed", { fg = '#c04c0d', bg = 'none' })
-- require("ibl").setup({
--   indent = { char = "⁚", highlight = { "NonText" } },
--   scope = { enabled = true, char = "│", highlight = { "RedRed" }, show_start = false, show_end = false }
-- })
