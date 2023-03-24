local macos = jit.os == 'OSX'

vim.g.mapleader = ' '

-- Delete to blackhole register
vim.keymap.set('n', '<Leader>d', '"_d', { silent = true })
vim.keymap.set('v', '<Leader>d', '"_d', { silent = true })

-- Insert date time as YYYY-MM-DD-HH:mm
vim.keymap.set('n', '<Leader>pb', '"=strftime("%Y%m%d%H%M")<CR>p')

-- Prepare replace all occurrences of word under cursor
vim.keymap.set('n', '<Leader>wr', [[:%s/\<<C-r><C-w>\>//g<Left><Left>]])
vim.keymap.set('i', '<C-c>', '<Esc>', { silent = true })

vim.keymap.set("n", "Q", "<nop>", { silent = true })
vim.keymap.set('n', 'Y', 'y$', { silent = true })

-- Jump next/prev but centered
vim.keymap.set('n', 'n', 'nzzzv', { silent = true })
vim.keymap.set('n', 'N', 'Nzzzv', { silent = true })
vim.keymap.set('n', '*', '*zz', { silent = true })
vim.keymap.set('n', '#', '#zz', { silent = true })
vim.keymap.set('n', 'g*', 'g*zz', { silent = true })
vim.keymap.set('n', 'G', 'Gzz', { silent = true })
vim.keymap.set('n', '<C-o>', '<C-o>zz', { silent = true })
vim.keymap.set('n', '<C-i>', '<C-i>zz', { silent = true })
vim.keymap.set('n', '<C-\'>', '<C-\'>zz', { silent = true })

-- Move down/up centered
vim.keymap.set('n', '<C-d>', '<C-d>zz', { silent = true })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { silent = true })

-- Moving lines up or down preserving format
vim.keymap.set('n', '<Leader>j', ':m .+1<CR>==', { silent = true })
vim.keymap.set('n', '<Leader>k', ':m .-2<CR>==', { silent = true })
vim.keymap.set('i', '<C-j>', '<Esc>:m .+1<CR>==gi', { silent = true })
vim.keymap.set('i', '<C-k>', '<Esc>:m .-2<CR>==gi', { silent = true })
vim.keymap.set('v', 'J', ':m \'>+1<CR>gv=gv', { silent = true })
vim.keymap.set('v', 'K', ':m \'<-2<CR>gv=gv', { silent = true })

-- Join line with cursor at beginning of line
vim.keymap.set("n", "J", "mzJ`z", { silent = true })

-- Resize windows
vim.keymap.set('n', '<Leader><Up>', ':resize -2<CR>', { silent = true })
vim.keymap.set('n', '<Leader><Down>', ':resize +2<CR>', { silent = true })
vim.keymap.set('n', '<Leader><Left>', ':vertical resize +2<CR>', { silent = true })
vim.keymap.set('n', '<Leader><Right>', ':vertical resize -2<CR>', { silent = true })

-- Copy to system clipboard
if macos then
  vim.keymap.set('v', '<C-y>', '"*y', { silent = true })
else
  vim.keymap.set('v', '<C-y>', '"+y', { silent = true })
end

-- Toggle between current and prev buffers
vim.keymap.set('n', '``', '<C-^>', { silent = true })

-- Close buffer without changing window layout
vim.keymap.set('n', '--', ':bp|bd #<CR>', { silent = true })
-- Close all but current buffer
vim.keymap.set('n', '<M-Q>', ':%bd|e #<CR>', { silent = true })

-- Go next/prev buffer using Tab
vim.keymap.set('n', '<Tab>', ':bn<CR>', { silent = true })
vim.keymap.set('n', '<S-Tab>', ':bp<CR>', { silent = true })

-- Select all text in current buffer
vim.keymap.set('n', '<M-a>', 'ggVG', { silent = true })
vim.keymap.set('i', '<M-a>', '<Esc>ggVG', { silent = true })

-- Open new file adjacent to current file
vim.keymap.set('n', '<Leader>o', ':e <C-R>=expand("%:h") . "/"<CR>')
vim.keymap.set('n', '<Leader>vo', ':vsp | e <C-R>=expand("%:h") . "/"<CR>')
-- Go to previous buffer and open # in vertical split
vim.keymap.set('n', '<Leader>ts', ':bp | vs #')

-- Paste formatted
vim.keymap.set('n', 'p', 'p=`]', { silent = true })
vim.keymap.set('n', 'P', 'P=`]', { silent = true })
vim.keymap.set('n', '<C-p>', 'p', { silent = true })
-- Fix indent in file
vim.keymap.set('n', '<Leader>T', 'gg=G', { silent = true })

-- Quick new lines
vim.keymap.set('i', '<M-o>', '<C-o>o', { silent = true })
vim.keymap.set('i', '<M-O>', '<C-o>O', { silent = true })

-- Terminal keymaps
vim.keymap.set('i', '<F12>', '<Esc>:term<CR>', { silent = true })
vim.keymap.set('i', '<F10>', '<Esc>:vs term://zsh<CR>', { silent = true })
vim.keymap.set('n', '<F12>', ':term<CR>', { silent = true })
vim.keymap.set('n', '<F10>', ':vs term://zsh<CR>', { silent = true })
-- Close terminal
vim.keymap.set('t', '<C-q>', '<C-\\><C-n>:bd!<CR>', { silent = true })
-- Esc goes to normal mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { silent = true })
vim.keymap.set('n', '<Leader>S', ':mks! .session.vim<CR>')

-- Copy current file relative path to clipboard
if macos then
  vim.keymap.set('n', '<Leader>P', ':let @*=expand("%:~:.")<CR>')
else
  vim.keymap.set('n', '<Leader>P', ':let @+=expand("%:~:.")<CR>')
end

-- Git
vim.keymap.set('n', '<C-g>s', ':!git stage %<CR>')
vim.keymap.set('n', '<C-g><Up>', ':!git push<CR>')
vim.keymap.set('n', '<C-g><Down>', ':!git pull<CR>')
