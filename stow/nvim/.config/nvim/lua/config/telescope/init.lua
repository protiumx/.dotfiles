local actions = require('config.telescope.actions')
local pickers = require('config.telescope.pickers')
local themes = require('config.telescope.themes')
local utils = require('config.utils')

local plenary = require('plenary.path')

local telescope = require('telescope')
local builtin = require('telescope.builtin')

local map = function(mode, l, r, desc)
  local opts = { silent = true, desc = '[Telescope] ' .. desc }
  vim.keymap.set(mode, l, r, opts)
end

-- Set current folder as prompt title
local options_with_cwd_title = function(opts, extra)
  extra = extra or {}
  local path = opts.cwd or opts.path or extra.cwd or extra.path or nil
  local title = ''
  local buf_path = vim.fn.expand('%:p:h')
  local cwd = vim.fn.getcwd()
  if path ~= nil and buf_path ~= cwd then
    title = plenary:new(buf_path):make_relative(cwd)
  else
    -- get the tail
    title = vim.fn.fnamemodify(cwd, ':t')
  end

  return vim.tbl_extend('force', opts, {
    prompt_title = title,
  }, extra or {})
end

local function keymaps()
  local dropdown = themes.get_dropdown()

  map({ 'i', 'n' }, '<M-]>', function()
    builtin.find_files(options_with_cwd_title(dropdown))
  end, 'Find files')

  map({ 'i', 'n' }, '<M-}>', function()
    builtin.find_files(options_with_cwd_title(dropdown, { cwd = vim.fn.expand('%:p:h') }))
  end, 'Find files relative to buffer')

  map({ 'i', 'n' }, '<M-_>', function()
    builtin.find_files(options_with_cwd_title({}))
  end, 'Find files with preview')

  map({ 'i', 'n' }, '<M-->', function()
    builtin.find_files(options_with_cwd_title({ cwd = vim.fn.expand('%:p:h') }))
  end, 'Find files with preview relative to buffer')

  map({ 'i', 'n' }, '<M-f>', function()
    telescope.extensions.file_browser.file_browser(options_with_cwd_title(dropdown, {
      path = '%:p:h',
    }))
  end, 'Browse files relative to buffer')

  map({ 'i', 'n' }, '<M-F>', function()
    telescope.extensions.file_browser.file_browser({
      path = '%:p:h',
      grouped = true,
      hidden = true,
    })
  end, 'Browse files relative to buffer with preview')

  map({ 'i', 'n' }, '<M-g>', function()
    builtin.live_grep(options_with_cwd_title({ cwd = vim.fn.expand('%:p:h') }))
  end, '[S]earch Live [G]rep relative buffer')

  map({ 'i', 'n' }, '<M-G>', function()
    builtin.live_grep(options_with_cwd_title({}))
  end, '[S]earch Live [G]rep')

  map({ 'i', 'n' }, '<M-b>', function()
    pickers.buffers(dropdown)
  end, 'Find buffers')

  map({ 'v' }, '<M-s>g', function()
    local search = utils.get_selection_text()
    builtin.grep_string({ search = search, prompt_title = 'Searh: ' .. string.sub(search, 0, 20) })
  end, '[S]earch Live [G]rep from visual selection')

  map({ 'i', 'n' }, '<M-s>w', function()
    builtin.grep_string(options_with_cwd_title({ cwd = vim.fn.expand('%:p:h') }))
  end, '[S]earch [W]ord under cursor in cwd relative to buffer')

  map({ 'i', 'n' }, '<M-s>W', function()
    builtin.grep_string({})
  end, '[S]earch [W]ord under cursor in cwd')

  map('n', '<M-s>h', builtin.help_tags, '[S]earch [H]elp')
  map('n', '<M-s>k', builtin.keymaps, '[S]earch [K]eymaps')

  map({ 'i', 'n' }, '<M-/>', function()
    builtin.current_buffer_fuzzy_find({
      theme = 'dropdown',
    })
  end, 'Fuzzy search in buffer')

  map({ 'i', 'n' }, '<M-s>s', function()
    builtin.spell_suggest(telescope_themes.get_cursor())
  end, '[S]pell [S]uggestions')

  map('n', '<C-g>b', builtin.git_branches, '[G]it [B]ranches')
  map('n', '<C-g>h', builtin.git_bcommits, '[G]it [H]istory of buffer')
  map('n', '<C-g>c', builtin.git_commits, '[G]it [C]ommits')
  map('n', '<C-g>S', function()
    builtin.git_status(dropdown)
  end, '[G]it [S]tatus')

  map('n', '<M-l>d', builtin.diagnostics, '[L]SP [D]iagnostics')
  map('n', '<M-l>c', builtin.diagnostics, '[L]SP Incoming [C]alls')
  map({ 'i', 'n' }, '<M-l>s', function()
    builtin.lsp_document_symbols(dropdown)
  end, '[L]SP [S]ymbols')

  map({ 'i', 'n' }, '<M-s>R', builtin.resume, 'Resume last search')
  map('n', '<M-s>p', builtin.pickers, '[S]earch [P]revious pickers')

  -- Projects
  map('n', '<M-s>P', function()
    telescope.extensions.projects.projects(dropdown)
  end, '[S]earch [P]rojects')

  -- Neoclip
  map({ 'n', 'i', 'v' }, '<M-y>', function()
    telescope.extensions.neoclip.default(themes.get_dropdown({ previewer = true }))
  end, 'Search Yanks')

  map({ 'n', 'i' }, '<M-s>m', function()
    telescope.extensions.macroscope.default(themes.get_dropdown({ previewer = true }))
  end, '[S]earch [M]acros')

  map(
    { 'i', 'n' },
    '<M-s>f',
    telescope.extensions.live_grep_args.live_grep_args,
    'Ripgrep with args'
  )
end

local M = {}

function M.setup()
  local dropdown = themes.get_dropdown()

  vim.api.nvim_create_augroup('startup', { clear = true })
  vim.api.nvim_create_autocmd('VimEnter', {
    group = 'startup',
    pattern = '*',
    callback = function()
      -- Open file browser if argument is a folder
      local arg = vim.api.nvim_eval('argv(0)')
      if arg and (vim.fn.isdirectory(arg) ~= 0 or arg == '') then
        vim.defer_fn(function()
          builtin.find_files(options_with_cwd_title(dropdown))
        end, 50)
      end
    end,
  })

  telescope.setup({
    defaults = {
      dynamic_preview_title = true,
      winblend = 20,
      show_line = false,
      borderchars = {
        prompt = { ' ' },
        results = { ' ' },
        preview = { ' ' },
      },
      prompt_prefix = '󰿟 ',
      prompt_title = '',
      results_title = '',
      preview_title = '',
      selection_caret = ' ',
      multi_icon = '+ ',
      sorting_strategy = 'ascending',
      layout_strategy = 'flex',
      layout_config = {
        horizontal = {
          prompt_position = 'top',
          preview_width = 0.64,
        },
        vertical = {
          mirror = false,
        },
        width = { 0.85, max = 158 },
        height = 0.80,
      },
      path_display = { 'truncate' },
      mappings = {
        i = {
          ['<M-x>'] = 'delete_buffer',
          ['<M-O>'] = actions.select_window,
          ['<M-Down>'] = 'cycle_history_next',
          ['<M-Up>'] = 'cycle_history_prev',
        },
        n = {
          ['q'] = 'close',
        },
      },
      vimgrep_arguments = {
        'rg',
        '--line-number',
        '--column',
        '--hidden',
        '--smart-case',
        '-u',
      },
    },
    preview = {
      filesize_limit = 0.2, -- MB
    },
    pickers = {
      find_files = {
        find_command = {
          'fd',
          '-t',
          'f',
          '--hidden',
          '--strip-cwd-prefix',
          '-i',
          '-E',
          '.git/*',
          '-E',
          'target/*',
          '-E',
          '**/node_modules',
          '-E',
          '.DS_Store',
        },
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
  vim.cmd([[autocmd User TelescopePreviewerLoaded setlocal wrap]])
end

return M
