local colors = require('config.colors')

vim.cmd.colorscheme('PaperColor')

vim.g['PaperColor_Theme_Options'] = {
  theme = {
    default = { dark = { override = { color07 = { colors.white, '' } } } }
  }
}

-- Highlights

-- Transparent background
-- vim.api.nvim_set_hl(0, 'LineNr', {bg = 'none'})
-- vim.api.nvim_set_hl(0, 'Normal', {bg = 'none'})
-- vim.api.nvim_set_hl(0, 'NonText', {bg = 'none'})
-- vim.api.nvim_set_hl(0, 'SignColumn', {bg = 'none'})

vim.api.nvim_set_hl(0, 'VertSplit', { bg = 'none', fg = colors.grey })
vim.api.nvim_set_hl(0, 'ColorColumn', { bg = colors.purple })

vim.api.nvim_set_hl(0, 'Cursor', { bg = colors.accent })
vim.api.nvim_set_hl(0, 'CursorColumn', { bg = 'none', fg = colors.accent })
vim.api.nvim_set_hl(0, 'Search', { bg = colors.accent })
vim.api.nvim_set_hl(0, 'CursorLine', { bg = 'none', fg = 'none' })

vim.api.nvim_set_hl(0, 'IncSearch', { bg = colors.purple, fg = 'none' })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'none' })

vim.api.nvim_set_hl(0, 'SpellBad', { bg = 'none', fg = 'none', undercurl = true, ctermbg = 'none', ctermfg = 'none' })
vim.api.nvim_set_hl(0, 'SpellRare', { bg = 'none', fg = 'none', undercurl = true, ctermbg = 'none', ctermfg = 'none' })
vim.api.nvim_set_hl(0, 'SpellLocal', { bg = 'none', fg = 'none', undercurl = true, ctermbg = 'none', ctermfg = 'none' })

-- Diagnostic
vim.api.nvim_set_hl(0, 'DiagnosticError', { fg = colors.red })
vim.api.nvim_set_hl(0, 'DiagnosticWarn', { fg = colors.yellow })
vim.api.nvim_set_hl(0, 'DiagnosticSignHint', { fg = colors.grey, bold = true })
vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextHint', { bg = 'none' })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineError', { undercurl = true })
vim.api.nvim_set_hl(0, 'DiagnosticFloatingHint', { bg = 'none' })
vim.api.nvim_set_hl(0, 'DiagnosticFloatingInfo', { bg = 'none' })
vim.api.nvim_set_hl(0, 'DiagnosticFloatingWarn', { bg = 'none', fg = colors.yellow })
vim.api.nvim_set_hl(0, 'DiagnosticFloatingError', { bg = 'none', fg = colors.red })
