local colors = require('config.colors')

-- require('gruvbox').setup({
--   undercurl = true,
--   underline = true,
--   bold = true,
--   contrast = "",
--   palette_overrides = {
--     dark0 = colors.background,
--     dark1 = colors.background,
--   },
--   dim_inactive = false,
--   transparent_mode = true,
-- })

vim.g.sonokai_style = 'default'
vim.g.sonokai_better_performance = 1
vim.g.sonokai_menu_selection_background = 'green'

vim.cmd('colorscheme sonokai')


-- vim.cmd [[colorscheme kanagawa]]
colors.load()

local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, "Transparent", { fg = "none", bg = 'none' })
end)

require("ibl").setup({
  indent = { char = " " },
  scope = { enabled = true, char = "▏", highlight = { "NonText" }, show_start = false, show_end = false }
})
