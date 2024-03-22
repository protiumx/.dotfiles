local ui = require('config.ui')
local actions = require('config.telescope.actions')
local pickers = require('config.telescope.pickers')
local themes = require('config.telescope.themes')
local utils = require('config.utils')

local plenary = require('plenary.path')

local telescope = require('telescope')
local telescope_actions = require('telescope.actions')
local builtin = require('telescope.builtin')

local map = function(mode, l, r, desc)
  local opts = { silent = true, desc = '[Telescope] ' .. desc }
  vim.keymap.set(mode, l, r, opts)
end

---Returns buffer directory relative to cwd
---@param cwd string | nil
local function get_buffer_dir(cwd)
  cwd = cwd or vim.fn.getcwd()
  local buf_path = vim.fn.expand('%:p:h')
  if buf_path ~= cwd then
    return plenary:new(buf_path):make_relative(cwd)
  else
    return vim.fn.fnamemodify(cwd, ':t')
  end
end

local function keymaps()
  local telescope_themes = require('telescope.themes')
  local dropdown = themes.get_dropdown()
  local extensions = telescope.extensions

  map({ 'i', 'n' }, '<M-]>', function()
    builtin.find_files(themes.get_dropdown({
      prompt_title = utils.get_cwd_name(),
    }))
  end, 'Find files')

  map({ 'i', 'n' }, '<M-}>', function()
    local cwd = vim.fn.expand('%:p:h')
    builtin.find_files(themes.get_dropdown({
      cwd = cwd,
      prompt_title = get_buffer_dir(cwd),
    }))
  end, 'Find files relative to buffer')

  map({ 'i', 'n' }, '<M-_>', function()
    builtin.find_files({
      prompt_title = utils.get_cwd_name(),
    })
  end, 'Find files with preview')

  map({ 'i', 'n' }, '<M-->', function()
    local cwd = vim.fn.expand('%:p:h')
    builtin.find_files({
      cwd = cwd,
      prompt_title = get_buffer_dir(),
    })
  end, 'Find files with preview relative to buffer')

  map({ 'i', 'n' }, '<M-f>', function()
    extensions.file_browser.file_browser(themes.get_dropdown({
      path = '%:p:h',
    }))
  end, 'Browse files relative to buffer')

  map({ 'i', 'n' }, '<M-F>', function()
    extensions.file_browser.file_browser({
      path = '%:p:h',
      grouped = true,
      hidden = true,
    })
  end, 'Browse files relative to buffer with preview')

  map({ 'i', 'n' }, '<M-g>', function()
    local cwd = vim.fn.expand('%:p:h')
    builtin.live_grep({ cwd = cwd, prompt_title = get_buffer_dir(cwd) })
  end, '[S]earch Live [G]rep relative buffer')

  map({ 'i', 'n' }, '<M-G>', function()
    builtin.live_grep({
      prompt_title = utils.get_cwd_name(),
    })
  end, '[S]earch Live [G]rep')

  map({ 'i', 'n' }, '<M-b>', function()
    pickers.buffers(dropdown)
  end, 'Find buffers')

  map({ 'v' }, '<M-s>g', function()
    local search = utils.get_selection_text()
    builtin.grep_string({ search = search, prompt_title = 'Searh: ' .. string.sub(search, 0, 20) })
  end, '[S]earch Live [G]rep from visual selection')

  map({ 'i', 'n' }, '<M-s>w', function()
    local cwd = vim.fn.expand('%:p:h')
    builtin.grep_string({ cwd = cwd, prompt_title = get_buffer_dir(cwd) })
  end, '[S]earch [W]ord under cursor in cwd relative to buffer')

  map({ 'i', 'n' }, '<M-s>W', function()
    builtin.grep_string({
      prompt_title = utils.get_cwd_name(),
    })
  end, '[S]earch [W]ord under cursor in cwd')

  map('n', '<M-s>h', builtin.help_tags, '[S]earch [H]elp')
  map('n', '<M-s>k', builtin.keymaps, '[S]earch [K]eymaps')

  map({ 'i', 'n' }, '<M-/>', function()
    builtin.current_buffer_fuzzy_find({
      theme = 'dropdown',
    })
  end, 'Fuzzy search in buffer')

  map({ 'i', 'n' }, '<M-s>s', function()
    builtin.spell_suggest(telescope_themes.get_cursor(themes.base))
  end, '[S]pell [S]uggestions')

  map('n', '<C-g>bb', builtin.git_branches, '[G]it [B]ranches')
  map('n', '<C-g>H', builtin.git_bcommits, '[G]it [H]istory of buffer')
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
    telescope.extensions.neoclip.default({})
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
  vim.api.nvim_create_augroup('startup', { clear = true })
  vim.api.nvim_create_autocmd('VimEnter', {
    group = 'startup',
    pattern = '*',
    callback = function()
      -- Open file browser if argument is a folder
      local arg = vim.api.nvim_eval('argv(0)')
      if arg and (vim.fn.isdirectory(arg) ~= 0 or arg == '') then
        vim.defer_fn(function()
          builtin.find_files(themes.get_dropdown({ prompt_title = get_buffer_dir() }))
        end, 50)
      end
    end,
  })
  local trouble = require('trouble.providers.telescope')

  local fb_actions = require('telescope').extensions.file_browser.actions

  telescope.setup({
    defaults = {
      dynamic_preview_title = true,
      winblend = ui.winblend,
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
          ['<M-a>'] = 'toggle_all', -- select/deselect all entries
          ['<M-i>'] = 'insert_symbol_i',
          ['<M-q>s'] = telescope_actions.send_selected_to_qflist + telescope_actions.open_qflist,
          ['<M-q>a'] = 'add_selected_to_qflist',
          ['<M-Q>'] = telescope_actions.send_to_qflist + telescope_actions.open_qflist,
          ['<C-t>'] = trouble.open_with_trouble,
        },
        n = {
          ['q'] = 'close',
          ['<Esc>'] = 'close',
        },
      },
      preview = {
        filesize_limit = 5, -- MB
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
        mappings = {
          ['i'] = {
            ['<M-R>'] = fb_actions.remove,
            ['<M-d>'] = false,
          },
        },
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
