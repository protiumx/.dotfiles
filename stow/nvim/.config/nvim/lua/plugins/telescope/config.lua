local actions = require('plugins.telescope.actions')
local pickers = require('plugins.telescope.pickers')
local themes = require('plugins.telescope.themes')

local ui = require('config.ui')
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
    extensions.file_browser.file_browser(themes.get_ivy({
      path = '%:p:h',
      grouped = true,
      hidden = true,
    }))
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

  map({ 'i', 'n', 'v' }, '<M-s>w', function()
    local cwd = vim.fn.expand('%:p:h')
    local search = nil
    local title = get_buffer_dir(cwd)
    if vim.fn.mode() == 'v' then
      search = utils.get_selection_text()
      title = 'Searh: ' .. string.sub(search, 0, 20)
    end

    builtin.grep_string({ search = search, cwd = cwd, prompt_title = title })
  end, '[S]earch [W]ord under cursor in cwd relative to buffer')

  map({ 'i', 'n', 'v' }, '<M-s>W', function()
    local search = nil
    local title = utils.get_cwd_name()
    if vim.fn.mode() == 'v' then
      search = utils.get_selection_text()
      title = 'Searh: ' .. string.sub(search, 0, 20)
    end

    builtin.grep_string({ search = search, prompt_title = title })
  end, '[S]earch [W]ord under cursor in cwd')

  map('n', '<M-s>h', builtin.help_tags, '[S]earch [H]elp')
  map('n', '<M-s>k', builtin.keymaps, '[S]earch [K]eymaps')

  map({ 'i', 'n' }, '<M-/>', function()
    builtin.current_buffer_fuzzy_find(themes.get_ivy())
  end, 'Fuzzy search in buffer')

  map({ 'i', 'n' }, '<M-s>s', function()
    builtin.spell_suggest(telescope_themes.get_cursor(themes.base))
  end, '[S]pell [S]uggestions')

  map('n', '<M-s>gb', builtin.git_branches, '[G]it [B]ranches')
  map('n', '<M-s>gbc', builtin.git_bcommits, '[G]it [H]istory of buffer')
  map('n', '<M-s>gc', builtin.git_commits, '[G]it [C]ommits')
  map('n', '<M-s>gs', function()
    builtin.git_status(dropdown)
  end, '[G]it [S]tatus')

  map('n', '<M-s>ld', builtin.diagnostics, '[L]SP [D]iagnostics')
  map('n', '<M-s>lc', builtin.diagnostics, '[L]SP Incoming [C]alls')
  map({ 'i', 'n' }, '<M-s>ls', function()
    builtin.lsp_document_symbols(dropdown)
  end, '[L]SP [S]ymbols')

  map({ 'i', 'n' }, "<M-'>", builtin.resume, 'Resume last search')

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
end

return function()
  local group = vim.api.nvim_create_augroup('startup', { clear = true })
  vim.api.nvim_create_autocmd('VimEnter', {
    group = group,
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

  local fb_actions = require('telescope').extensions.file_browser.actions

  telescope.setup({
    defaults = {
      dynamic_preview_title = true,
      winblend = ui.winblend,
      show_line = false,
      borderchars = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
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
          ['<M-k>'] = 'cycle_history_next',
          ['<M-j>'] = 'cycle_history_prev',
          ['<M-a>'] = 'toggle_all', -- select/deselect all entries
          ['<M-q>'] = false, -- remove keymap
          ['<M-q>s'] = telescope_actions.send_selected_to_qflist + telescope_actions.open_qflist,
          ['<M-q>a'] = 'add_selected_to_qflist',
          ['<M-q>o'] = telescope_actions.send_to_qflist + telescope_actions.open_qflist,
        },
        n = {
          ['q'] = 'close',
          ['<Esc>'] = 'close',
        },
      },
      preview = {
        filesize_limit = 1, -- MB
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
      buffers = {
        disable_devicons = true,
      },

      live_grep = {
        disable_devicons = true,
        theme = 'ivy',
        borderchars = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
      },

      find_files = {
        disable_devicons = true,
        theme = 'ivy',
        -- stylua: ignore
        find_command = {
          'fd',
          '-t', 'f',
          '--hidden',
          '--strip-cwd-prefix',
          '-i',
          '-E', '.git/*',
          '-E', '.venv/*',
          '-E', 'target/*',
          '-E', '**/node_modules',
          '-E', '.DS_Store',
          '-E', '.bin',
          '-E', '**/bin',
        },
      },
    },

    extensions = {
      file_browser = {
        respect_gitignore = false,
        disable_devicons = true,
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
  telescope.load_extension('neoclip')

  keymaps()

  -- wrap text in preview
  vim.cmd([[autocmd User TelescopePreviewerLoaded setlocal wrap]])
end
