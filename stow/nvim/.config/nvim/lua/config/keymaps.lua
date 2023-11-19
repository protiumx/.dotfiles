local macos = jit.os == 'OSX'

vim.g.mapleader = ' '

-- Delete to blackhole register
vim.keymap.set('n', '<Leader>d', '"_d', { silent = true })
vim.keymap.set('v', '<Leader>d', '"_d', { silent = true })

-- Prepare replace all occurrences of word under cursor
vim.keymap.set(
  'n',
  '<Leader>wr',
  [[:%s/\<<C-r><C-w>\>//g<Left><Left>]],
  { desc = 'Prepare current word sustituion' }
)
vim.keymap.set('i', '<C-c>', '<Esc>', { silent = true })

vim.keymap.set('n', 'Q', '<nop>', { silent = true })
vim.keymap.set('n', 'Y', 'y$', { silent = true })

-- Jump next/prev but centered
vim.keymap.set('n', 'n', 'nzzzv', { silent = true })
vim.keymap.set('n', 'N', 'Nzzzv', { silent = true })
vim.keymap.set('n', '*', '*zz', { silent = true })
vim.keymap.set('n', '#', '#zz', { silent = true })
vim.keymap.set('n', 'g*', 'g*zz', { silent = true })
vim.keymap.set('n', 'G', 'Gzz', { silent = true })

-- Move down/up centered
vim.keymap.set('n', '<C-d>', '<C-d>zz', { silent = true })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { silent = true })

-- Move lines up/down preserving format
vim.keymap.set('n', '<M-j>', '<cmd>m .+1<CR>==', { silent = true })
vim.keymap.set('n', '<M-k>', '<cmd>m .-2<CR>==', { silent = true })
vim.keymap.set('i', '<C-j>', '<cmd>m .+1<CR>==gi', { silent = true })
vim.keymap.set('i', '<C-k>', '<cmd>m .-2<CR>==gi', { silent = true })
vim.keymap.set('v', '<C-j>', "<cmd>m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set('v', '<C-k>', "<cmd>m '<-2<CR>gv=gv", { silent = true })

-- Join line with cursor at beginning of line using z as mark
vim.keymap.set('n', 'J', 'mzJ`z', { silent = true })

-- Resize windows
vim.keymap.set('n', '<Leader><Up>', '<cmd>resize -2<CR>', { silent = true })
vim.keymap.set('n', '<Leader><Down>', '<cmd>resize +2<CR>', { silent = true })
vim.keymap.set('n', '<Leader><Left>', '<cmd>vertical resize +2<CR>', { silent = true })
vim.keymap.set('n', '<Leader><Right>', '<cmd>vertical resize -2<CR>', { silent = true })
-- Navigate windows
vim.keymap.set('n', '<Leader>h', '<C-w>h', { silent = true })
vim.keymap.set('n', '<Leader>j', '<C-w>j', { silent = true })
vim.keymap.set('n', '<Leader>k', '<C-w>k', { silent = true })
vim.keymap.set('n', '<Leader>l', '<C-w>l', { silent = true })

-- Toggle between current and prev buffers
vim.keymap.set('n', '``', '<C-^>', { silent = true })
-- Close buffer without changing window layout
vim.keymap.set('n', '--', '<cmd>e # | bd #<CR>', { silent = true })
-- Close all except the current buffer
vim.keymap.set('n', '<M-Q>', '<cmd>%bd | e #<CR>', { silent = true })

-- Go next/prev buffer using Tab
vim.keymap.set('n', '<Tab>', '<cmd>bn<CR>', { silent = true })
vim.keymap.set('n', '<S-Tab>', '<cmd>bp<CR>', { silent = true })
-- Tab navigation
vim.keymap.set({ 't', 'n' }, "<M-'>", '<cmd>tabn<CR>', { silent = true })
vim.keymap.set({ 't', 'n' }, '<M-\\>', '<cmd>tabp<CR>', { silent = true })

-- Select all text in current buffer
vim.keymap.set('n', '<M-a>', 'ggVG', { silent = true })
vim.keymap.set('i', '<M-a>', '<Esc>ggVG', { silent = true })

-- Open new file adjacent to current file
vim.keymap.set('n', '<Leader>o', '<cmd>e <C-R>=expand("%:h") . "/"<CR>')
vim.keymap.set('n', '<Leader>vo', '<cmd>vsp | e <C-R>=expand("%:h") . "/"<CR>')
-- Go to previous buffer and open # in vertical split
vim.keymap.set('n', '<Leader>bs', '<cmd>bp | vs #<CR>')

-- Go to end after yank or paste
vim.keymap.set({ 'n', 'v' }, 'p', 'p`]', { silent = true })
vim.keymap.set({ 'n', 'v' }, 'P', 'P`]', { silent = true })
vim.keymap.set('v', 'y', 'y`]', { silent = true })

vim.keymap.set('n', 'gV', '`[v`]', { silent = true, desc = 'Select what was pasted' })

-- Fix indent in file
vim.keymap.set('n', '<Leader>T', 'gg=G')

-- Quick new lines
vim.keymap.set('i', '<M-o>', '<C-o>o', { silent = true })
vim.keymap.set('i', '<M-O>', '<C-o>O', { silent = true })

-- Terminal keymaps
vim.keymap.set({ 'i', 'n' }, '<F12>', '<cmd>$tabnew term://zsh<CR>', { silent = true })
-- Close terminal
vim.keymap.set('t', '<C-q>', '<cmd>bd!<CR>', { silent = true })
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { silent = true, desc = 'Normal mode from term' })
vim.keymap.set('t', '``', '<cmd>tabn<CR>', { silent = true }) -- avoid switching buffers

vim.keymap.set('n', '<Leader>S', ':mks! .session.vim<CR>')

if macos then
  -- Copy to system clipboard
  vim.keymap.set('v', '<C-y>', '"*y', { silent = true })
  vim.keymap.set('n', '<Leader>P', function()
    local path = vim.fn.expand('%:~:.')
    vim.fn.setreg('*', path)
    print('Copied: ' .. path)
  end, { desc = 'copy current path to clipboard' })
  vim.keymap.set('n', '<Leader>L', function()
    local path = vim.fn.expand('%:h') .. '/' .. vim.fn.expand('%:t') .. ':' .. vim.fn.line('.')
    vim.fn.setreg('*', path)
    print('Copied: ' .. path)
  end, { desc = 'copy current path with line and column to clipboard' })
else
  vim.keymap.set('v', '<C-y>', '"+y', { silent = true })
  vim.keymap.set('n', '<Leader>P', function()
    local path = vim.fn.expand('%:~:.')
    vim.fn.setreg('+', path)
    print('Copied: ' .. path)
  end, { desc = 'copy current path to clipboard' })
  vim.keymap.set('n', '<Leader>L', function()
    local path = vim.fn.expand('%:h') .. '/' .. vim.fn.expand('%:t') .. ':' .. vim.fn.line('.')
    vim.fn.setreg('+', path)
    print('Copied: ' .. path)
  end, { desc = 'copy current path with line and column to clipboard' })
end

-- Git
vim.keymap.set('n', '<C-g>s', function()
  vim.cmd([[!git stage %]])
  print('Staged: ' .. vim.fn.expand('%'))
end, { desc = '[Git] stage current file', silent = true })

vim.keymap.set('n', '<C-g><Up>', '<cmd>!git push<CR>', { desc = '[Git] push' })

vim.keymap.set('n', '<C-g><Down>', '<cmd>!git pull<CR>', { desc = '[Git] pull' })

vim.keymap.set('n', '<C-g>R', function()
  vim.cmd('!git checkout origin/main %')
  print('Reset: ' .. vim.fn.expand('%'))
end, { desc = '[Git] reset current file', silent = true })

vim.keymap.set('n', '<M-v>', 'gv', { silent = true, desc = 'activate previous visual block' })

vim.keymap.set('i', '<M-g>ud', function()
  local uuid, _ = vim.fn.system('uuidgen'):gsub('\n', ''):lower()
  vim.api.nvim_put({ uuid }, 'c', false, true)
end, { silent = true, desc = 'Insert UUID' })
-- Insert current date as ISO YYYY-MM-DD-HH:mm
vim.keymap.set('i', '<M-g>id', '<Esc>"=strftime("%Y-%m-%dT%H:%M")<CR>p')
-- Insert build date
vim.keymap.set('i', '<M-g>bd', '"=strftime("%Y%m%d%H%M")<CR>p')

-- Quickfix navigation
vim.keymap.set('n', '<Leader>ql', '<cmd>cn<CR>')
vim.keymap.set('n', '<Leader>qh', '<cmd>cp<CR>')
vim.keymap.set('n', '<Leader>qo', '<cmd>copen<CR>')
vim.keymap.set('n', '<Leader>Q', '<cmd>cclose<CR>')

vim.keymap.set('n', '&', '<nop>')

vim.keymap.set({ 'n', 'v' }, 'H', '^', { silent = true })
vim.keymap.set({ 'n', 'v' }, 'L', '$', { silent = true })

vim.keymap.set('n', '<Leader>s', '<cmd>w<CR>')
vim.keymap.set('n', '<Leader>g', 'g<C-g>')

vim.keymap.set('v', '\\', 'y/<C-R>"<CR>', { desc = 'Search for highlighted text' })
