local M = {}

local function keymaps()
  local telescope = require('telescope')
  local builtin = require('telescope.builtin')
  local themes = require('telescope.themes')
  local previewers = require('telescope.previewers')

  local map = function(mode, l, r, desc)
    local opts = { silent = true, desc = '[Telescope] ' .. desc }

    vim.keymap.set(mode, l, r, opts)
  end

  local dropdown = themes.get_dropdown({
    previewer = false,
    prompt_title = '',
    preview_title = '',
    results_title = '',
    layout_config = { prompt_position = 'top' },
  })

  -- File browser always relative to buffer
  local opts_file_browser = vim.tbl_extend('force', dropdown, {
    grouped = true,
    hidden = true,
    path = '%:p:h',
  })

  -- Set current folder as prompt title
  local with_title = function(opts, extra)
    return vim.tbl_extend('force', opts, {
      prompt_title = opts.cwd and vim.fn.expand('%:p:h:t') or vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
    }, extra or {})
  end

  map({ 'i', 'n' }, '<M-]>', function()
    builtin.find_files(with_title(dropdown))
  end, 'Find files')

  map({ 'i', 'n' }, '<M-}>', function()
    builtin.find_files(with_title(dropdown, { cwd = vim.fn.expand('%:p:h') }))
  end, 'Find files relative to buffer')

  map({ 'i', 'n' }, '<M-->', function()
    builtin.find_files(with_title({}))
  end, 'Find files with preview')

  map({ 'i', 'n' }, '<M-_>', function()
    builtin.find_files(with_title({ cwd = vim.fn.expand('%:p:h') }))
  end, 'Find files with preview relative to buffer')

  map({ 'i', 'n' }, '<C-b>', function() builtin.buffers(dropdown) end, 'Find buffers')

  map('n', '<M-f>', function()
    telescope.extensions.file_browser.file_browser(with_title(opts_file_browser))
  end, 'Browse files relative to buffer')

  map('n', '<M-F>', function()
    telescope.extensions.file_browser.file_browser({ path = '%:p:h' })
  end, 'Browse files relative to buffer with preview')

  map('n', '<Leader>sg', builtin.live_grep, '[S]earch Live [G]rep')
  map('n', '<Leader>sw', builtin.grep_string, '[S]earch [W]ord under cursor in cwd')
  map('n', '<Leader>sh', builtin.help_tags, '[S]earch [H]elp')
  map('n', '<Leader>sk', builtin.keymaps, '[S]earch [K]eymaps')

  map('n', '<Leader>/', function()
    builtin.current_buffer_fuzzy_find({
      theme = 'dropdown',
    })
  end, 'Fuzzy search in buffer')

  map('n', '<Leader>ss', function()
    builtin.spell_suggest(themes.get_cursor())
  end, '[S]pell [S]uggestions')

  map('n', '<C-g>b', builtin.git_branches, '[G]it [B]ranches')
  map('n', '<C-g>h', builtin.git_bcommits, '[G]it [H]istory of buffer')
  map('n', '<C-g>C', builtin.git_commits, '[G]it [C]ommits')

  map('n', '<Leader>sd', builtin.diagnostics, '[S]earch [D]iagnostics')
  map('n', '<Leader>sS', builtin.lsp_document_symbols, '[S]earch [S]ymbols (LSP)')
  map('n', '<Leader>sR', builtin.resume, 'Resume last search')
  map('n', '<Leader>sT', function() builtin.treesitter(dropdown) end, '[S]earch [T]reesitter')
  map('n', '<Leader>sc', function() builtin.commands_history(dropdown) end, '[S]earch [C]ommands history')

  -- Projects
  map('n', '<Leader>sp', telescope.extensions.projects.projects, '[S]earch [P]rojects')

  -- Neoclip
  map({ 'n', 'i' }, '<M-y>', function()
    telescope.extensions.neoclip.default(themes.get_dropdown())
  end, 'Search Yanks')

  map('n', '<Leader>sm', function()
    telescope.extensions.macroscope.default(themes.get_dropdown())
  end, '[S]earch [M]acros')
end

function M.setup()
  local telescope = require('telescope')
  local previewers = require('telescope.previewers')
  telescope.setup({
    defaults = {
      prompt_prefix = '❯ ',
      prompt_title = '',
      results_title = '',
      preview_title = '',
      selection_caret = '❯ ',
      multi_icon = '+ ',

      layout_strategy = 'flex',
      layout_config = { height = 0.9, width = 0.9 },

      mappings = {
        i = {
          ['<M-d>'] = 'delete_buffer'
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
    },
  })


  telescope.load_extension('fzf')
  telescope.load_extension('file_browser')
  telescope.load_extension('projects')
  telescope.load_extension('neoclip')

  keymaps()

  -- wrap text in preview
  vim.cmd [[autocmd User TelescopePreviewerLoaded setlocal wrap]]
end

return M
