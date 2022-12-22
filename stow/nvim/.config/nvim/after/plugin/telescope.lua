local telescope = require('telescope')
telescope.setup({
  defaults = {
    prompt_prefix = '❯ ',
    selection_caret = '❯ ',

    layout_config = { height = 0.95, width = 0.9 },

    mappings = {
      i = {
        ['<C-q>'] = 'delete_buffer'
      },
    },

    vimgrep_arguments = {
      'rg',
      '--line-number',
      '--column',
      '--hidden',
      '--smart-case',
      '-u'
    },

    file_ignore_patterns = { 'target/*', 'node_modules/*', '^.git/*', '^.yarn/*' },
  },
  pickers = {
    find_files = {
      find_command = { 'fd', '-t', 'f', '--hidden', '--strip-cwd-prefix', '-i' }
    },
  }
})

-- telescope.load_extension('fzf')
telescope.load_extension('file_browser')

local builtin = require('telescope.builtin')
local minimal = { previewer = false, theme = 'dropdown' }

vim.keymap.set({'i', 'n'}, '<C-]>', function()
  builtin.find_files(minimal)
end, { silent = true })

vim.keymap.set({'i', 'n'}, '<C-h>', builtin.find_files, { silent = true })

vim.keymap.set({'i', 'n'}, '<C-b>', function()
  builtin.buffers(minimal)
end, { silent = true })

-- Open in current file folder
vim.keymap.set('n', '<Leader><C-]>', function()
  local cwd = vim.fn.finddir('.git/..', vim.fn.expand('%:p:h'))
  local opts = { grouped=true, hidden=true, previewer=false, theme='dropdown', path='%:p:h', cwd=cwd}
  telescope.extensions.file_browser.file_browser(opts)
end, { silent = true })

vim.keymap.set('n', '<Leader><C-h>', function()
  local cwd = vim.fn.finddir('.git/..', vim.fn.expand('%:p:h'))
  local opts = { grouped=true, hidden=true, previewer=false, theme='dropdown', cwd=cwd}
  telescope.extensions.file_browser.file_browser(opts)
end, { silent = true })

vim.keymap.set('n', '<Leader>sg', builtin.live_grep, { silent = true })
-- find word under cursor
vim.keymap.set('n', '<Leader>sw', builtin.grep_string, { silent = true })
vim.keymap.set('n', '<Leader>sr', builtin.registers, { silent = true })

vim.keymap.set('n', '<Leader>sh', builtin.help_tags, { silent = true })
vim.keymap.set('n', '<Leader>sk', builtin.keymaps, { silent = true })
vim.keymap.set('n', '<Leader>/', function()
  builtin.current_buffer_fuzzy_find(minimal)
end, { silent = true })

vim.keymap.set('n', '<Leader>sc', builtin.colorscheme, { silent = true })
-- LSP quick fix
vim.keymap.set('n', '<Leader>sqf', builtin.quickfix, { silent = true })

-- Spell suggestions for word under cursor
vim.keymap.set('n', '<Leader>ssp', function()
  builtin.spell_suggest(require('telescope.themes').get_cursor())
end, { silent = true })

-- Show git diff
vim.keymap.set('n', '<Leader>sG', builtin.git_status, { silent = true })

vim.keymap.set('n', '<Leader>sd', builtin.diagnostics, { silent = true, desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<Leader>sS', builtin.lsp_document_symbols, { silent = true, desc = '[S]earch [S]ymbols' })
vim.keymap.set('n', '<Leader>sl', builtin.resume, { silent = true, desc = '[S]earch [L]ast' })

vim.cmd [[autocmd User TelescopePreviewerLoaded setlocal wrap]]
