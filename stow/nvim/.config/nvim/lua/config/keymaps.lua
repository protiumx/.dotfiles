local utils = require('config.utils')

local macos = jit.os == 'OSX'
local system_clip_reg = macos and '*' or '+'

vim.g.mapleader = ' '
vim.keymap.set('i', '<C-c>', '<Esc>', { silent = true })

vim.keymap.set('n', 'gx', function()
  local file = vim.fn.expand('<cfile>')
  file = vim.fn.shellescape(file)
  vim.cmd('!open ' .. file)
end, { silent = true })

-- General movements
-- Move down/up centered
vim.keymap.set('n', '<C-d>', '<C-d>zz', { silent = true })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { silent = true })
vim.keymap.set('n', '<C-o>', '<C-o>zz', { silent = true })
vim.keymap.set('n', '<C-i>', '<C-i>zz', { silent = true })
-- Next/prev match centered
vim.keymap.set('n', 'n', 'nzzzv', { silent = true })
vim.keymap.set('n', 'N', 'Nzzzv', { silent = true })
vim.keymap.set('n', '*', '*zz', { silent = true })
vim.keymap.set('n', '#', '#zz', { silent = true })
vim.keymap.set('n', 'g*', 'g*zz', { silent = true })
vim.keymap.set('n', 'G', 'Gzz', { silent = true })

vim.keymap.set({ 'n', 'v' }, 'H', '^', { silent = true })
vim.keymap.set({ 'n', 'v' }, 'L', '$', { silent = true })

-- Move lines up/down preserving format
vim.keymap.set('n', '<M-j>', ':m .+1<CR>==', { silent = true })
vim.keymap.set('n', '<M-k>', ':m .-2<CR>==', { silent = true })
vim.keymap.set('v', '<M-j>', ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set('v', '<M-k>', ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set('i', '<M-j>', '<Esc>:m .+1<CR>==gi', { silent = true })
vim.keymap.set('i', '<M-k>', '<Esc>:m .-2<CR>==gi', { silent = true })

-- Quickfix
vim.keymap.set('n', '<Leader>qo', '<cmd>copen<CR>')
vim.keymap.set('n', '<Leader>qq', '<cmd>cclose<CR>')
vim.keymap.set(
  'n',
  '<Leader>Q',
  '<cmd>call setqflist([]) | cclose<CR>',
  { desc = 'Clean quickfix' }
)
--
vim.keymap.set({ 'n', 'v' }, '<Leader>qd', function()
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
vim.keymap.set('n', '<Leader><Up>', '<cmd>resize -2<CR>', { silent = true })
vim.keymap.set('n', '<Leader><Down>', '<cmd>resize +2<CR>', { silent = true })
vim.keymap.set('n', '<Leader><Left>', '<cmd>vertical resize +2<CR>', { silent = true })
vim.keymap.set('n', '<Leader><Right>', '<cmd>vertical resize -2<CR>', { silent = true })
vim.keymap.set('n', '<Leader>h', '<C-w>h', { silent = true })
vim.keymap.set('n', '<Leader>j', '<C-w>j', { silent = true })
vim.keymap.set('n', '<Leader>k', '<C-w>k', { silent = true })
vim.keymap.set('n', '<Leader>l', '<C-w>l', { silent = true })
vim.keymap.set('n', '<Leader>V', '<C-w>|', { silent = true })
vim.keymap.set('n', '<Leader>H', '<C-w>-', { silent = true })
vim.keymap.set('n', '<Leader>0', '<C-w>=', { silent = true })
-- Buffer utils
vim.keymap.set('n', '<Leader>bp', '<cmd>vs #<CR>', { desc = 'Open previous buffer in new vsplit' })
vim.keymap.set('n', '<Tab>', '<cmd>bn<CR>', { silent = true })
vim.keymap.set('n', '<S-Tab>', '<cmd>bp<CR>', { silent = true })
vim.keymap.set('n', '<Leader>`', '<C-^>', { silent = true })
vim.keymap.set('n', '--', function()
  utils.delete_buffer(0, { wipe = true })
end, { silent = true, desc = 'Wipe buffer and go to previous' })
vim.keymap.set('n', '<Leader>bd', function()
  utils.delete_buffer(0, { wipe = false })
end, { silent = true, desc = 'Delete buffer and go to previous' })

vim.keymap.set(
  'n',
  '<Leader>bx',
  '<cmd>%bd | e #<CR>',
  { silent = true, desc = 'Close all but current buffer' }
)

-- Terminal utils
vim.keymap.set({ 't', 'n' }, "<M-'>", '<cmd>tabn<CR>', { silent = true })
vim.keymap.set({ 't', 'n' }, '<M-\\>', '<cmd>tabp<CR>', { silent = true })
vim.keymap.set(
  { 'i', 'n', 'v' },
  '<F10>',
  '<cmd>vs term://zsh<CR>',
  { silent = true, desc = 'Open terminal in vertical split' }
)
vim.keymap.set(
  { 'i', 'n', 'v' },
  '<F12>',
  '<cmd>$tabnew term://zsh<CR>',
  { silent = true, desc = 'Open terminal in new tab at last position' }
)
vim.keymap.set('t', '<C-q>', '<cmd>bd!<CR>', { silent = true, desc = 'Close terminal buffer' })
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { silent = true, desc = 'Term normal mode' })
-- vim.keymap.set('t', '<Leader>`', '<cmd>tabn<CR>', { silent = true }) -- avoid switching buffers
vim.keymap.set('t', '<M-h>', '<cmd>wincmd h<CR>', { silent = true })
vim.keymap.set('t', '<M-j>', '<cmd>wincmd j<CR>', { silent = true })
vim.keymap.set('t', '<M-k>', '<cmd>wincmd k<CR>', { silent = true })
vim.keymap.set('t', '<M-l>', '<cmd>wincmd l<CR>', { silent = true })

-- Git utils
vim.keymap.set('n', '<M-,>', function()
  local cmd = vim.fn.expand('git stage %')
  vim.cmd('!' .. cmd)
  print(cmd)
end, { desc = '[Git] stage current file', silent = true })
vim.keymap.set('n', '<C-g>r', function()
  local cmd = vim.fn.expand('git checkout origin/main %')
  vim.cmd('!' .. cmd)
  print(cmd)
end, { desc = '[Git] checkout current file', silent = true })

-- No OPs
vim.keymap.set('n', '&', '<nop>', { silent = true })
vim.keymap.set('n', 'Q', '<nop>', { silent = true })

-- Registers utils
vim.keymap.set('n', 'Y', 'y$', { silent = true })
vim.keymap.set(
  'v',
  '<C-y>',
  '"' .. system_clip_reg .. 'y',
  { silent = true, desc = 'Junk into reg ' .. system_clip_reg }
)
vim.keymap.set({ 'n', 'v' }, '<Leader>dd', '"_d', { silent = true, desc = 'Delete to blackwhole' })
vim.keymap.set({ 'n', 'v' }, '<Leader>cc', '"_c', { silent = true, desc = 'Delete to blackwhole' })

-- General utils
vim.keymap.set('n', '<Leader>T', 'gg=G', { desc = 'Fix indent in whole file' })
vim.keymap.set(
  { 'n', 'v' },
  'p',
  ']p',
  { silent = true, desc = 'Paste and go to begining of selection' }
)
vim.keymap.set({ 'v' }, 'y', 'y`]', { silent = true, desc = 'Yank and go to end of selection' })
vim.keymap.set({ 'n' }, 'P', ']P', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<C-p>', 'p', { silent = true, desc = 'Default p command' })
vim.keymap.set('n', '<Leader>vp', '`[v`]', { silent = true, desc = 'Select what was pasted' })
vim.keymap.set(
  'n',
  '<Leader>wr',
  [[:%s/\<<C-r><C-w>\>//g<Left><Left>]],
  { desc = 'Prepare current word sustituion buffer wise' }
)
vim.keymap.set('n', 'J', 'mzJ`z', { silent = true, desc = 'Join line keeping cursor postion' })
vim.keymap.set(
  'v',
  '<Leader>:',
  [[:s/\%V]],
  { silent = true, desc = 'Search replace only in visual selection' }
)
vim.keymap.set('n', '<Leader>P', function()
  local path = vim.fn.expand('%:~:.')
  vim.fn.setreg(system_clip_reg, path)
  print('Copied: ' .. path)
end, { desc = 'Copy current path to reg ' .. system_clip_reg })

vim.keymap.set('n', '<Leader>L', function()
  local path = vim.fn.expand('%:~:.') .. ':' .. vim.fn.line('.')
  vim.fn.setreg(system_clip_reg, path)
  print('Copied: ' .. path)
end, { desc = 'Copy current path with line and column to reg ' .. system_clip_reg })

vim.keymap.set('n', '<Leader>s', '<cmd>w<CR>', { desc = 'Quick save' })
vim.keymap.set('n', '<Leader>G', 'g<C-g>', { desc = 'File stats' })
vim.keymap.set('n', '<Leader>S', '<cmd>mks! .session.vim<CR>', { desc = 'Create session' })
vim.keymap.set('i', '<M-o>', '<C-o>o', { silent = true, desc = 'New line below' })
vim.keymap.set('i', '<M-O>', '<C-o>O', { silent = true, desc = 'New line above' })
vim.keymap.set(
  'n',
  '<Leader>o',
  ':e <C-R>=expand("%:h") . "/"<CR>',
  { desc = 'Populates cmd with current file' }
)
vim.keymap.set(
  'n',
  '<Leader>vo',
  ':vsp | e <C-R>=expand("%:h") . "/"<CR>',
  { desc = 'Populates cmd with current file and vs' }
)
-- Select all text in current buffer
vim.keymap.set('n', '<M-a>', 'ggVG', { silent = true, desc = 'Select all' })
vim.keymap.set('i', '<M-a>', '<Esc>ggVG', { silent = true, desc = 'Select all' })
