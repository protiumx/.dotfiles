local M = {}

local function keymaps()
  local telescope = require('telescope')
  local builtin = require('telescope.builtin')
  local dropdown = { previewer = false, theme = 'dropdown' }

  vim.keymap.set({ 'i', 'n' }, '<C-]>', function()
    builtin.find_files(dropdown)
  end, { silent = true })

  vim.keymap.set({ 'n' }, '<C-h>', builtin.find_files, { silent = true })

  vim.keymap.set({ 'i', 'n' }, '<C-b>', function()
    builtin.buffers(dropdown)
  end, { silent = true })

  -- Open in current file's folder
  vim.keymap.set('n', '<M-g>', function()
    local opts = { grouped = true, hidden = true, previewer = false, theme = 'dropdown', path = '%:p:h' }
    telescope.extensions.file_browser.file_browser(opts)
  end, { silent = true })

  vim.keymap.set('n', '<M-f>', function()
    local opts = { grouped = true, hidden = true, previewer = false, theme = 'dropdown' }
    telescope.extensions.file_browser.file_browser(opts)
  end, { silent = true })

  vim.keymap.set('n', '<Leader>sg', builtin.live_grep, { silent = true })
  -- find word under cursor
  vim.keymap.set('n', '<Leader>sw', builtin.grep_string, { silent = true })
  vim.keymap.set('n', '<Leader>sr', builtin.registers, { silent = true })

  vim.keymap.set('n', '<Leader>sh', builtin.help_tags, { silent = true })
  vim.keymap.set('n', '<Leader>sk', builtin.keymaps, { silent = true })
  vim.keymap.set('n', '<Leader>/', function()
    builtin.current_buffer_fuzzy_find(dropdown)
  end, { silent = true })

  vim.keymap.set('n', '<Leader>st', builtin.colorscheme, { silent = true })

  -- Spell suggestions for word under cursor
  vim.keymap.set('n', '<Leader>ss', function()
    builtin.spell_suggest(require('telescope.themes').get_cursor())
  end, { silent = true })

  -- Show git diff
  vim.keymap.set('n', '<Leader>sG', builtin.git_status, { silent = true })

  vim.keymap.set('n', '<Leader>sd', builtin.diagnostics, { silent = true, desc = '[S]earch [D]iagnostics' })
  vim.keymap.set('n', '<Leader>sS', builtin.lsp_document_symbols, { silent = true, desc = '[S]earch [S]ymbols' })
  vim.keymap.set('n', '<Leader>sR', builtin.resume, { silent = true, desc = '[S]earch [R]esume' })

  -- Projects
  vim.keymap.set('n', '<Leader>sp', function()
    require('telescope').extensions.projects.projects({})
  end, { silent = true, desc = '[S]earch [P]rojects' })

  vim.cmd [[autocmd User TelescopePreviewerLoaded setlocal wrap]]

  -- Neoclip
  vim.keymap.set({ 'n', 'i' }, '<M-y>', function()
    telescope.extensions.neoclip.default()
  end, { silent = true, desc = 'Search Yanks' })

  vim.keymap.set('n', '<Leader>sm', function()
    telescope.extensions.macroscope.default()
  end, { silent = true, desc = '[S]earch [M]acros' })
end

function M.setup()
  local telescope = require('telescope')
  telescope.setup({
    defaults = {
      prompt_prefix = '❯ ',
      selection_caret = '❯ ',
      multi_icon = '+ ',

      layout_strategy = 'flex',
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


  telescope.load_extension('fzf')
  telescope.load_extension('file_browser')
  telescope.load_extension('projects')
  telescope.load_extension('neoclip')

  keymaps()
end

return M
