local saga = require('lspsaga')
local keymap = vim.keymap.set

saga.init_lsp_saga({
  code_action_icon = ' ',
})

keymap('n', 'gh', '<cmd>Lspsaga lsp_finder<CR>', { silent = true })
keymap({ 'n', 'v' }, '<Leader>vca', '<cmd>Lspsaga code_action<CR>', { silent = true })
keymap('n', '<Leader>rn', '<cmd>Lspsaga rename<CR>', { silent = true })
keymap('n', 'gpd', '<cmd>Lspsaga peek_definition<CR>', { silent = true })

-- Only jump to error
keymap('n', '[E', function()
  require('lspsaga.diagnostic').goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true })
keymap('n', ']E', function()
  require('lspsaga.diagnostic').goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true })

-- Outline
keymap('n', '<Leader>so', '<cmd>Lspsaga outline<CR>', { silent = true })
