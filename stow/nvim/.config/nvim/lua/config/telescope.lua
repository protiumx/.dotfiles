local M = {}

local function keymaps()
  local utils = require('config.utils')
  local plenary = require('plenary.path')
  local telescope = require('telescope')
  local builtin = require('telescope.builtin')
  local themes = require('telescope.themes')

  local map = function(mode, l, r, desc)
    local opts = { silent = true, desc = '[Telescope] ' .. desc }

    vim.keymap.set(mode, l, r, opts)
  end

  local dropdown = themes.get_dropdown({
    hidden = true,
    no_ignore = true,
    previewer = false,
    prompt_title = '',
    preview_title = '',
    results_title = '',
    layout_config = { prompt_position = 'top' },
  })

  -- File browser always relative to buffer
  local opts_file_browser = vim.tbl_extend('force', dropdown, {
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
      title = plenary:new(buf_path):make_relative(cwd)
    else
      title = vim.fn.fnamemodify(cwd, ':t')
    end

    return vim.tbl_extend('force', opts, {
      prompt_title = title
    }, extra or {})
  end

  vim.api.nvim_create_augroup('startup', { clear = true })
  vim.api.nvim_create_autocmd('VimEnter', {
    group = 'startup',
    pattern = '*',
    callback = function()
      -- Open file browser if argument is a folder
      local arg = vim.api.nvim_eval('argv(0)')
      if arg and (vim.fn.isdirectory(arg) ~= 0 or arg == "") then
        vim.defer_fn(function()
          builtin.find_files(with_title(dropdown))
        end, 50)
      end
    end
  })

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

  map({ 'i', 'n' }, '<M-f>', function()
    telescope.extensions.file_browser.file_browser(with_title(opts_file_browser))
  end, 'Browse files relative to buffer')

  map({ 'i', 'n' }, '<M-F>', function()
    telescope.extensions.file_browser.file_browser({
      path = '%:p:h',
      grouped = true,
      hidden = true,
    })
  end, 'Browse files relative to buffer with preview')

  map({ 'i', 'n' }, '<M-G>', function()
    builtin.live_grep(with_title({}))
  end, '[S]earch Live [G]rep')

  map({ 'i', 'n' }, '<M-g>', function()
    builtin.live_grep(with_title({ cwd = vim.fn.expand('%:p:h') }))
  end, '[S]earch Live [G]rep relative buffer')

  map({ 'v' }, '<M-s>g', function()
    local search = utils.vtext()
    builtin.grep_string({ search = search })
  end, '[S]earch Live [G]rep from visual selection')

  map({ 'i', 'n' }, '<M-s>w', function()
    builtin.grep_string({})
  end, '[S]earch [W]ord under cursor in cwd')

  map({ 'i', 'n' }, '<M-s>W', function()
    builtin.grep_string(with_title({ cwd = vim.fn.expand('%:p:h') }))
  end, '[S]earch [W]ord under cursor in cwd relative to buffer')

  map('n', '<M-s>h', builtin.help_tags, '[S]earch [H]elp')
  map('n', '<M-s>k', builtin.keymaps, '[S]earch [K]eymaps')

  map({ 'i', 'n' }, '<M-/>', function()
    builtin.current_buffer_fuzzy_find({
      theme = 'dropdown',
    })
  end, 'Fuzzy search in buffer')

  map({ 'i', 'n' }, '<M-s>s', function()
    builtin.spell_suggest(themes.get_cursor())
  end, '[S]pell [S]uggestions')

  map('n', '<C-g>b', builtin.git_branches, '[G]it [B]ranches')
  map('n', '<C-g>h', builtin.git_bcommits, '[G]it [H]istory of buffer')
  map('n', '<C-g>C', builtin.git_commits, '[G]it [C]ommits')

  map('n', '<M-s>d', builtin.diagnostics, '[S]earch [D]iagnostics')
  map({ 'i', 'n' }, '<M-s>S', builtin.lsp_document_symbols, '[S]earch [S]ymbols (LSP)')
  map({ 'i', 'n' }, '<M-s>r', builtin.resume, 'Resume last search')
  map('n', '<M-s>p', builtin.pickers, '[S]earch [P]revious pickers')
  map({ 'i', 'n' }, '<M-s>t', function() builtin.treesitter(dropdown) end, '[S]earch [T]reesitter')

  -- Projects
  map('n', '<M-s>P', function()
    telescope.extensions.projects.projects(dropdown)
  end, '[S]earch [P]rojects')

  -- Neoclip
  map({ 'n', 'i', 'v', 'x' }, '<M-y>', function()
    telescope.extensions.neoclip.default(dropdown)
  end, 'Search Yanks')

  map('n', '<M-s>m', function()
    telescope.extensions.macroscope.default(dropdown)
  end, '[S]earch [M]acros')

  -- Rg with args

  map({ 'i', 'n' }, '<M-s>f', telescope.extensions.live_grep_args.live_grep_args, 'Ripgrep with args')
end

function M.setup()
  local telescope = require('telescope')
  local action_state = require("telescope.actions.state")

  telescope.setup({
    defaults = {
      prompt_prefix = '❯ ',
      prompt_title = '',
      results_title = '',
      preview_title = '',
      selection_caret = '❯ ',
      multi_icon = '+ ',
      sorting_strategy = 'ascending',
      layout_strategy = 'flex',
      layout_config = {
        horizontal = {
          prompt_position = 'top',
          preview_width = 0.55,
        },
        vertical = {
          mirror = false,
        },
        width = 0.85,
        height = 0.80,
      },
      path_display = { 'truncate' },
      mappings = {
        i = {
          ['<M-D>'] = 'delete_buffer',
          ['<M-Down>'] = 'cycle_history_next',
          ['<M-Up>'] = 'cycle_history_prev',
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
      file_ignore_patterns = { 'target/*', 'node_modules/*', '.git/*', '.yarn/*' },
    },
    pickers = {
      find_files = {
        find_command = { 'fd', '-t', 'f', '--hidden', '--strip-cwd-prefix', '-i' }
      },
    },
    extensions = {
      file_browser = {
        respect_gitignore = false,
        grouped = true,
        hidden = true,
        git_status = false,
      },
    },
  })


  telescope.load_extension('fzf')
  telescope.load_extension('file_browser')
  telescope.load_extension('projects')
  telescope.load_extension('neoclip')
  telescope.load_extension('live_grep_args')

  keymaps()

  -- wrap text in preview
  vim.cmd [[autocmd User TelescopePreviewerLoaded setlocal wrap]]
end

return M
