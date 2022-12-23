vim.cmd.colorscheme('PaperColor')

vim.g['PaperColor_Theme_Options'] = {
  theme = {
    default = { dark = { override = { color07 = { '#e3e3e3', '' } } } }
  }
}

-- Highlights

-- Transparent background
-- vim.api.nvim_set_hl(0, 'LineNr', {bg = 'none'})
-- vim.api.nvim_set_hl(0, 'Normal', {bg = 'none'})
-- vim.api.nvim_set_hl(0, 'NonText', {bg = 'none'})
-- vim.api.nvim_set_hl(0, 'SignColumn', {bg = 'none'})

vim.api.nvim_set_hl(0, 'VertSplit', { bg = 'none', fg = '#454545' })
vim.api.nvim_set_hl(0, 'ColorColumn', { bg = '#5f5fd7' })

vim.api.nvim_set_hl(0, 'Cursor', { bg = '#fe5186' })
vim.api.nvim_set_hl(0, 'CursorColumn', { bg = 'none', fg = '#fe5186' })
vim.api.nvim_set_hl(0, 'Search', { bg = '#fe5186' })
vim.api.nvim_set_hl(0, 'CursorLine', { bg = 'none', fg = 'none' })

vim.api.nvim_set_hl(0, 'IncSearch', { bg = '#fe5186', fg = 'none' })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
vim.api.nvim_set_hl(0, 'SpellBad', { bg = 'none', fg = 'none', undercurl = true, ctermbg = 'none', ctermfg = 'none' })
vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'none' })
