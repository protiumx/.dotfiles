local M = {}

local function keymaps()
  local telescope = require('telescope')
  local builtin = require('telescope.builtin')
  local themes = require('telescope.themes')
  local Path = require('plenary.path')

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
    extra = extra or {}
    local path = opts.cwd or opts.path or extra.cwd or extra.path or nil
    local title = ''
    local buf_path = vim.fn.expand('%:p:h')
    local cwd = vim.fn.getcwd()
    if path ~= nil and buf_path ~= cwd then
      title = Path:new(buf_path):make_relative(cwd)
    else
      title = vim.fn.fnamemodify(cwd, ':t')
    end

    return vim.tbl_extend('force', opts, {
      prompt_title = title
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
    telescope.extensions.file_browser.file_browser({
      path = '%:p:h',
      grouped = true,
      hidden = true,
    })
  end, 'Browse files relative to buffer with preview')

  map('n', '<M-s>g', function()
    builtin.live_grep(with_title({}))
  end, '[S]earch Live [G]rep')

  map('n', '<M-s>G', function()
    builtin.live_grep(with_title({ cwd = vim.fn.expand('%:p:h') }))
  end, '[S]earch Live [G]rep relative buffer')

  map('n', '<M-s>w', function()
    builtin.grep_string(with_title({}))
  end, '[S]earch [W]ord under cursor in cwd')

  map('n', '<M-s>W', function()
    builtin.grep_string(with_title({ cwd = vim.fn.expand('%:p:h') }))
  end, '[S]earch [W]ord under cursor in cwd relative to buffer')

  map('n', '<M-s>h', builtin.help_tags, '[S]earch [H]elp')
  map('n', '<M-s>k', builtin.keymaps, '[S]earch [K]eymaps')

  map('n', '<M-s>/', function()
    builtin.current_buffer_fuzzy_find({
      theme = 'dropdown',
    })
  end, 'Fuzzy search in buffer')

  map('n', '<M-s>s', function()
    builtin.spell_suggest(themes.get_cursor())
  end, '[S]pell [S]uggestions')

  map('n', '<C-g>b', builtin.git_branches, '[G]it [B]ranches')
  map('n', '<C-g>h', builtin.git_bcommits, '[G]it [H]istory of buffer')
  map('n', '<C-g>C', builtin.git_commits, '[G]it [C]ommits')

  map('n', '<M-s>d', builtin.diagnostics, '[S]earch [D]iagnostics')
  map('n', '<M-s>S', builtin.lsp_document_symbols, '[S]earch [S]ymbols (LSP)')
  map('n', '<M-s>r', builtin.resume, 'Resume last search')
  map('n', '<M-s>t', function() builtin.treesitter(dropdown) end, '[S]earch [T]reesitter')

  -- Projects
  map('n', '<M-s>p', function()
    telescope.extensions.projects.projects(dropdown)
  end, '[S]earch [P]rojects')

  -- Neoclip
  map({ 'n', 'i' }, '<M-y>', function()
    telescope.extensions.neoclip.default(themes.get_dropdown())
  end, 'Search Yanks')

  map('n', '<M-s>m', function()
    telescope.extensions.macroscope.default(themes.get_dropdown())
  end, '[S]earch [M]acros')
end

function M.setup()
  local telescope = require('telescope')
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
