local macos = jit.os == 'OSX'
local system_clip_reg = macos and '*' or '+'

local utils = require('config.utils')

vim.g.mapleader = ' '
vim.keymap.set('i', '<C-c>', '<Esc>', { silent = true })

-- General movements
-- Move down/up centered
vim.keymap.set('n', '<C-d>', '<C-d>zz', { silent = true })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { silent = true })
vim.keymap.set('n', '<C-o>', '<C-o>zz', { silent = true })
vim.keymap.set('n', '<C-i>', '<C-i>zz', { silent = true })
vim.keymap.set('n', 'n', 'nzzzv', { silent = true })
vim.keymap.set('n', 'N', 'Nzzzv', { silent = true })
vim.keymap.set('n', '*', '*zz', { silent = true })
vim.keymap.set('n', '#', '#zz', { silent = true })
vim.keymap.set('n', 'g*', 'g*zz', { silent = true })
vim.keymap.set('n', 'G', 'Gzz', { silent = true })

vim.keymap.set({ 'n', 'v' }, 'H', '^', { silent = true })
vim.keymap.set({ 'n', 'v' }, 'L', '$', { silent = true })
vim.keymap.set(
  'n',
  '<Leader>gF',
  utils.open_file_under_cursor,
  { silent = true, desc = 'Opens the file under cursor and sets position' }
)
vim.keymap.set(
  'n',
  '<Leader>ge',
  utils.open_file_from_error,
  { silent = true, desc = 'Opens the file from errorformat and sets position' }
)
-- Move lines up/down preserving format
vim.keymap.set('n', '<M-j>', ':m .+1<CR>==', { silent = true })
vim.keymap.set('n', '<M-k>', ':m .-2<CR>==', { silent = true })
vim.keymap.set('v', '<M-j>', ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set('v', '<M-k>', ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set('i', '<M-j>', '<Esc>:m .+1<CR>==gi', { silent = true })
vim.keymap.set('i', '<M-k>', '<Esc>:m .-2<CR>==gi', { silent = true })

-- Quickfix navigation
vim.keymap.set('n', '<Leader>ql', '<cmd>cn<CR>')
vim.keymap.set('n', '<Leader>qh', '<cmd>cp<CR>')
vim.keymap.set('n', '<Leader>qo', '<cmd>copen<CR>')
vim.keymap.set('n', '<Leader>qx', '<cmd>call setqflist([])<CR>')
vim.keymap.set('n', '<Leader>Q', '<cmd>cclose<CR>')

-- Window utils
vim.keymap.set('n', '<Leader><Up>', '<cmd>resize -2<CR>', { silent = true })
vim.keymap.set('n', '<Leader><Down>', '<cmd>resize +2<CR>', { silent = true })
vim.keymap.set('n', '<Leader><Left>', '<cmd>vertical resize +2<CR>', { silent = true })
vim.keymap.set('n', '<Leader><Right>', '<cmd>vertical resize -2<CR>', { silent = true })
vim.keymap.set('n', '<Leader>h', '<C-w>h', { silent = true })
vim.keymap.set('n', '<Leader>j', '<C-w>j', { silent = true })
vim.keymap.set('n', '<Leader>k', '<C-w>k', { silent = true })
vim.keymap.set('n', '<Leader>l', '<C-w>l', { silent = true })
vim.keymap.set('n', '<C-w>S', '<cmd>bp | vs #<CR>', { desc = 'Open previous buffer in vsplit' })

-- Buffer utils
vim.keymap.set('n', '<C-w>B', '<cmd>vs #<CR>', { desc = 'Open previous buffer in vsplit' })
vim.keymap.set('n', '<Tab>', '<cmd>bn<CR>', { silent = true })
vim.keymap.set('n', '<S-Tab>', '<cmd>bp<CR>', { silent = true })
vim.keymap.set('n', '``', '<C-^>', { silent = true })
vim.keymap.set(
  'n',
  '--',
  '<cmd>e # | bd #<CR>',
  { silent = true, desc = 'Delete buffer and go to previous' }
)
vim.keymap.set('n', '<Leader>bb', '<cmd>bd<CR>', { silent = true })
vim.keymap.set(
  'n',
  '<M-X>',
  '<cmd>%bd | e #<CR>',
  { silent = true, desc = 'Close all but current buffer' }
)

-- Tab utils
vim.keymap.set({ 't', 'n' }, "<M-'>", '<cmd>tabn<CR>', { silent = true })
vim.keymap.set({ 't', 'n' }, '<M-\\>', '<cmd>tabp<CR>', { silent = true })

-- Terminal utils
vim.keymap.set(
  { 'i', 'n', 'v' },
  '<F12>',
  '<cmd>$tabnew term://zsh<CR>',
  { silent = true, desc = 'Open terminal in new tab in last position' }
)
vim.keymap.set(
  { 'i', 'n', 'v' },
  '<F10>',
  '<cmd>vs term://zsh<CR>',
  { silent = true, desc = 'Open terminal in vertical split' }
)
vim.keymap.set('t', '<C-q>', '<cmd>bd!<CR>', { silent = true, desc = 'Close terminal buffer' })
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { silent = true, desc = 'Term normal mode' })
vim.keymap.set('t', '``', '<cmd>tabn<CR>', { silent = true }) -- avoid switching buffers
vim.keymap.set('t', '<M-h>', '<cmd>wincmd h<CR>', { silent = true })
vim.keymap.set('t', '<M-j>', '<cmd>wincmd j<CR>', { silent = true })
vim.keymap.set('t', '<M-k>', '<cmd>wincmd k<CR>', { silent = true })
vim.keymap.set('t', '<M-l>', '<cmd>wincmd l<CR>', { silent = true })

-- Git utils
vim.keymap.set('n', '<C-g>s', function()
  local cmd = vim.expand('git stage %')
  vim.cmd('!' .. cmd)
  print(cmd)
end, { desc = '[Git] stage current file', silent = true })
vim.keymap.set('n', '<C-g><Up>', '<cmd>!git push<CR>', { desc = '[Git] push' })
vim.keymap.set('n', '<C-g><Down>', '<cmd>!git pull<CR>', { desc = '[Git] pull' })
vim.keymap.set('n', '<C-g>R', function()
  local cmd = vim.expand('git checkout origin/main %')
  vim.cmd('!' .. cmd)
  print(cmd)
end, { desc = '[Git] checkout current file', silent = true })

-- No OPs
vim.keymap.set('n', '&', '<nop>')
vim.keymap.set('n', 'Q', '<nop>', { silent = true })

-- Registers utils
vim.keymap.set('n', 'Y', 'y$', { silent = true })
vim.keymap.set(
  'v',
  '<C-y>',
  '"' .. system_clip_reg .. 'y',
  { silent = true, desc = 'Junk into reg ' .. system_clip_reg }
)
vim.keymap.set({ 'n', 'v' }, '<Leader>D', '"_d', { silent = true, desc = 'Delete to blackwhole' })
vim.keymap.set({ 'n', 'v' }, '<Leader>C', '"_c', { silent = true, desc = 'Delete to blackwhole' })
-- Delete shortcuts
vim.keymap.set({ 'n', 'v' }, '<Leader>d_', 'dt_')
vim.keymap.set({ 'n', 'v' }, '<Leader>d-', 'dt-')
vim.keymap.set({ 'n', 'v' }, '<Leacer>c_', 'ct_')
vim.keymap.set({ 'n', 'v' }, '<Leacer>c-', 'ct-')

-- General utils
vim.keymap.set('n', '<Leader>T', 'gg=G', { desc = 'Fix indent in whole file' })
-- Paste formatted and go to end of pasted block
vim.keymap.set({ 'n', 'v' }, 'p', ']p`]', { silent = true })
vim.keymap.set({ 'n' }, 'P', ']P`]', { silent = true })
vim.keymap.set({ 'v' }, 'y', 'y`]', { silent = true })
-- Normal p
vim.keymap.set({ 'n', 'v' }, '<C-p>', 'p', { silent = true })
vim.keymap.set('n', '<M-V>', '`[v`]', { silent = true, desc = 'Select what was pasted' })
vim.keymap.set('n', '<M-v>', 'gv', { silent = true, desc = 'activate previous visual block' })
vim.keymap.set(
  'n',
  '<Leader>wr',
  [[:%s/\<<C-r><C-w>\>//g<Left><Left>]],
  { desc = 'Prepare current word sustituion buffer wise' }
)
-- Join line with cursor at beginning of line using z as mark
vim.keymap.set('n', 'J', 'mzJ`z', { silent = true })
vim.keymap.set(
  'v',
  '<Leader>/',
  '"yy/<C-R>y<CR>',
  { desc = 'Yunk selected text into "y and put it in search' }
)
vim.keymap.set('n', '<Leader>P', function()
  local path = vim.fn.expand('%:~:.')
  vim.fn.setreg(system_clip_reg, path)
  print('Copied: ' .. path)
end, { desc = 'Copy current path to reg ' .. system_clip_reg })

vim.keymap.set('n', '<Leader>L', function()
  local path = vim.fn.expand('%:h') .. '/' .. vim.fn.expand('%:t') .. ':' .. vim.fn.line('.')
  vim.fn.setreg(system_clip_reg, path)
  print('Copied: ' .. path)
end, { desc = 'Copy current path with line and column to reg ' .. system_clip_reg })

vim.keymap.set('n', '<Leader>s', '<cmd>w<CR>', { desc = 'Quick save' })
vim.keymap.set('n', '<Leader>G', 'g<C-g>', { desc = 'File stats' })
vim.keymap.set('n', '<Leader>S', '<cmd>mks! .session.vim<CR>')
-- Quick new lines
vim.keymap.set('i', '<M-o>', '<C-o>o', { silent = true })
vim.keymap.set('i', '<M-O>', '<C-o>O', { silent = true })
-- Open new file adjacent to current file
vim.keymap.set('n', '<Leader>o', ':e <C-R>=expand("%:h") . "/"')
vim.keymap.set('n', '<Leader>vo', ':vsp | e <C-R>=expand("%:h") . "/"')
-- Select all text in current buffer
vim.keymap.set('n', '<M-a>', 'ggVG', { silent = true })
vim.keymap.set('i', '<M-a>', '<Esc>ggVG', { silent = true })
