local utils = require('config.utils')

local macos = jit.os == 'OSX'
local system_clip_reg = macos and '*' or '+'
local map = vim.keymap.set

vim.g.mapleader = ' '
vim.keymap.set('i', '<C-c>', '<Esc>', { silent = true })

map('n', 'gx', function()
  local file = vim.fn.expand('<cfile>')
  file = vim.fn.shellescape(file)
  vim.cmd('!open ' .. file)
end, { silent = true })

-- stylua: ignore start
-- General movements
-- Move down/up centered
map('n', '<C-d>', '<C-d>zz', { silent = true })
map('n', '<C-u>', '<C-u>zz', { silent = true })
map('n', '<C-o>', '<C-o>zz', { silent = true })
map('n', '<C-i>', '<C-i>zz', { silent = true })
-- Next/prev match centered
map('n', 'n', 'nzzzv', { silent = true })
map('n', 'N', 'Nzzzv', { silent = true })
map('n', '*', '*zz', { silent = true })
map('n', '#', '#zz', { silent = true })
map('n', 'g*', 'g*zz', { silent = true })
map('n', 'G', 'Gzz', { silent = true })

map({ 'n', 'v' }, 'H', '^', { silent = true })
map({ 'n', 'v' }, 'L', '$', { silent = true })

-- Move lines up/down preserving format
map('n', '<M-j>', ':m .+1<CR>==', { silent = true })
map('n', '<M-k>', ':m .-2<CR>==', { silent = true })
map('v', '<M-j>', ":m '>+1<CR>gv=gv", { silent = true })
map('v', '<M-k>', ":m '<-2<CR>gv=gv", { silent = true })
map('i', '<M-j>', '<Esc>:m .+1<CR>==gi', { silent = true })
map('i', '<M-k>', '<Esc>:m .-2<CR>==gi', { silent = true })

-- Quickfix
map('n', '<Leader>qo', '<cmd>copen<CR>')
map('n', '<Leader>qq', '<cmd>cclose<CR>')
map( 'n', '<Leader>Q', '<cmd>call setqflist([]) | cclose<CR>', { desc = 'Clean quickfix' })
map({ 'n', 'v' }, '<Leader>qd', function()
  local items = vim.fn.getqflist()
  if vim.bo.buftype ~= 'quickfix' or #items == 0 then
    return
  end

  local pos = utils.get_lines_indexes()
  local new_items = {}
  for i, item in ipairs(items) do
    if i < pos[1] or i > pos[2] then
      new_items[#new_items + 1] = item
    end
  end

  vim.fn.setqflist(new_items, 'r')
  if #new_items == 0 then
    return
  end

  local new_idx = math.min(pos[1], #new_items)
  vim.api.nvim_win_set_cursor(0, { new_idx, 0 })

  if vim.fn.mode() ~= 'n' then
    vim.api.nvim_input('<esc>')
  end
end, { desc = 'Delete qf entries' })

-- Window utils
map('n', '<Leader><Up>', '<cmd>resize -2<CR>', { silent = true })
map('n', '<Leader><Down>', '<cmd>resize +2<CR>', { silent = true })
map('n', '<Leader><Left>', '<cmd>vertical resize +2<CR>', { silent = true })
map('n', '<Leader><Right>', '<cmd>vertical resize -2<CR>', { silent = true })
map('n', '<Leader>h', '<C-w>h', { silent = true })
map('n', '<Leader>j', '<C-w>j', { silent = true })
map('n', '<Leader>k', '<C-w>k', { silent = true })
map('n', '<Leader>l', '<C-w>l', { silent = true })
map( 'n', '<Leader>V', '<C-w>|', { silent = true, desc = 'Make vertical split fullscreen' })
map( 'n', '<Leader>H', '<C-w>-', { silent = true, desc = 'Make horizontal split fullscreen' })
map('n', '<Leader>0', '<C-w>=', { silent = true, desc = 'Restore window layout' })
-- Buffer utils
map('n', '<Leader>bp', '<cmd>vs #<CR>', { desc = 'Open previous buffer in new vsplit' })
map('n', '<Tab>', '<cmd>bn<CR>', { silent = true })
map('n', '<S-Tab>', '<cmd>bp<CR>', { silent = true })
map('n', '<Leader>`', '<C-^>', { silent = true })
map('n', '--', function()
  utils.delete_buffer(0, { wipe = true })
end, { silent = true, desc = 'Wipe buffer and go to previous' })

map( 'n', '<Leader>bx', '<cmd>%bd | e #<CR>', { silent = true, desc = 'Close all but current buffer' })

-- Terminal utils
map({ 't', 'n' }, "<M-'>", '<cmd>tabn<CR>', { silent = true })
map({ 't', 'n' }, '<M-\\>', '<cmd>tabp<CR>', { silent = true })
map( { 'i', 'n', 'v' }, '<F10>', '<cmd>vs term://zsh<CR>', { silent = true, desc = 'Open terminal in vertical split' })
map( { 'i', 'n', 'v' }, '<F12>', '<cmd>$tabnew term://zsh<CR>', { silent = true, desc = 'Open terminal in new tab at last position' })
map('t', '<C-q>', '<cmd>bd!<CR>', { silent = true, desc = 'Close terminal buffer' })
map('t', '<Esc>', '<C-\\><C-n>', { silent = true, desc = 'Term normal mode' })
-- set('t', '<Leader>`', '<cmd>tabn<CR>', { silent = true }) -- avoid switching buffers
map('t', '<M-h>', '<cmd>wincmd h<CR>', { silent = true })
map('t', '<M-j>', '<cmd>wincmd j<CR>', { silent = true })
map('t', '<M-k>', '<cmd>wincmd k<CR>', { silent = true })
map('t', '<M-l>', '<cmd>wincmd l<CR>', { silent = true })

-- Git utils
map('n', '<M-,>', function()
  local cmd = vim.fn.expand('git stage %')
  vim.cmd('!' .. cmd)
  print(cmd)
end, { desc = '[Git] stage current file', silent = true })
map('n', '<C-g>r', function()
  local cmd = vim.fn.expand('git checkout origin/main %')
  vim.cmd('!' .. cmd)
  print(cmd)
end, { desc = '[Git] checkout current file', silent = true })

-- No OPs
map('n', '&', '<nop>', { silent = true })
map('n', 'Q', '<nop>', { silent = true })

-- Registers utils
map('n', 'Y', 'y$', { silent = true })
map( 'v', '<C-y>', '"' .. system_clip_reg .. 'y', { silent = true, desc = 'Junk into reg ' .. system_clip_reg })
map({ 'v' }, 'y', 'y`]', { silent = true, desc = 'Yank and go to end of selection' })
map({ 'n', 'v' }, '<Leader>dd', '"_d', { silent = true, desc = 'Delete to blackwhole' })
map({ 'n', 'v' }, '<Leader>cc', '"_c', { silent = true, desc = 'Delete to blackwhole' })

-- General utils
map('n', '<Leader>T', 'gg=G', { desc = 'Fix indent in whole file' })
map( { 'n', 'v' }, 'p', ']p', { silent = true, desc = 'Paste and go to begining of selection' })
map( { 'n' }, 'P', ']P', { silent = true, desc = 'Paste above and go to begining of selection' })
map({ 'n', 'v' }, '<C-p>', 'p', { silent = true, desc = 'Default p command' })
map('n', '<Leader>vp', '`[v`]', { silent = true, desc = 'Select what was pasted' })
map( 'n', '<Leader>wr', [[:%s/\<<C-r><C-w>\>//g<Left><Left>]], { desc = 'Prepare current word sustituion buffer wise' })
map('n', 'J', 'mzJ`z', { silent = true, desc = 'Join line keeping cursor postion' })
map( 'v', '<Leader>/', [[:s/\%V]], { silent = true, desc = 'Search replace only in visual selection' })
map('n', '<Leader>P', function()
  local path = vim.fn.expand('%:~:.')
  vim.fn.setreg(system_clip_reg, path)
  print('Copied: ' .. path)
end, { desc = 'Copy current path to reg ' .. system_clip_reg })
map('n', '<Leader>L', function()
  local path = vim.fn.expand('%:~:.') .. ':' .. vim.fn.line('.')
  vim.fn.setreg(system_clip_reg, path)
  print('Copied: ' .. path)
end, { desc = 'Copy current path with line and column to reg ' .. system_clip_reg })
map('n', '<Leader>s', '<cmd>w<CR>', { desc = 'Quick save' })
map('n', '<Leader>S', '<cmd>mks! .session.vim<CR>', { desc = 'Create session' })
map('i', '<M-o>', '<C-o>o', { silent = true, desc = 'New line below' })
map('i', '<M-O>', '<C-o>O', { silent = true, desc = 'New line above' })
map( 'n', '<Leader>o', ':e <C-R>=expand("%:h") . "/"<CR>', { desc = 'Populates cmd with current file' })
map( 'n', '<Leader>vo', ':vsp | e <C-R>=expand("%:h") . "/"<CR>', { desc = 'Populates cmd with current file and vs' })
-- Select all text in current buffer
map('n', '<M-a>', 'ggVG', { silent = true, desc = 'Select all' })
map('i', '<M-a>', '<Esc>ggVG', { silent = true, desc = 'Select all' })
-- stylua: ignore end
