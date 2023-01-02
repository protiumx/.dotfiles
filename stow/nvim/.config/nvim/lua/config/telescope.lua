local M = {}

local function keymaps()
  local telescope = require('telescope')
  local builtin = require('telescope.builtin')
  local previewers = require('telescope.previewers')
  local themes = require('telescope.themes')

  local delta = previewers.new_termopen_previewer({
    get_command = function(entry)
      if entry.status == '??' or 'A ' then
        return { 'git', 'diff', entry.value }
      end

      return { 'git', 'diff', entry.value .. '^!' }
    end
  })

  local map = function(mode, l, r, desc)
    local opts = { silent = true, desc = desc }

    vim.keymap.set(mode, l, r, opts)
  end

  local dropdown = themes.get_dropdown({
    previewer = false,
    layout_config = { prompt_position = 'top' },
  })


  local opts_file_browser = vim.tbl_extend('force', dropdown, {
    grouped = true,
    hidden = true,
  })

  local opts_file_browser_path = vim.tbl_extend('force', opts_file_browser, {
    path = '%:p:h',
  })

  map({ 'i', 'n' }, '<C-]>', function() builtin.find_files(dropdown) end, 'Find files')
  map({ 'n' }, '<C-h>', builtin.find_files, 'Find files with preview')

  map({ 'i', 'n' }, '<C-b>', function() builtin.buffers(dropdown) end, 'Find buffers')

  -- Open in current file's folder
  map('n', '<M-g>', function() telescope.extensions.file_browser.file_browser(opts_file_browser_path) end,
    'Browse files relative')
  map('n', '<M-f>', function() telescope.extensions.file_browser.file_browser(opts_file_browser) end, 'Browse files')

  map('n', '<Leader>sg', builtin.live_grep, '[S]earch [G]rep')

  -- find word under cursor
  map('n', '<Leader>sw', builtin.grep_string, '[S]earch [W]ord')
  map('n', '<Leader>sr', builtin.registers, '[S]earch [R]egisters')

  map('n', '<Leader>sh', builtin.help_tags, '[S]earch [H]elp')
  map('n', '<Leader>sk', builtin.keymaps, '[S]earch [K]eymaps')
  map('n', '<Leader>/', function() builtin.current_buffer_fuzzy_find(dropdown) end, 'Fuzzy search in buffer')

  map('n', '<Leader>st', builtin.colorscheme, '[S]earch [C]olor schemes')

  -- Spell suggestions for word under cursor
  map('n', '<Leader>ss', function() builtin.spell_suggest(themes.get_cursor()) end, '[S]earch [S]pell suggestions')

  -- Show git diff
  map('n', '<Leader>Gs', function() builtin.git_status({ previeer = delta, layout_strategy = 'vertical' }) end,
    '[G]it [S]tatus')
  map('n', '<Leader>Gb', builtin.git_branches, '[G]it [B]ranches')
  map('n', '<Leader>Gh', builtin.git_bcommits, '[G]it [H]istory of buffer')
  map('n', '<Leader>Gc', builtin.git_commits, '[G]it [C]ommits')

  map('n', '<Leader>sd', builtin.diagnostics, '[S]earch [D]iagnostics')
  map('n', '<Leader>sR', builtin.resume, '[S]earch [R]esume')
  map('n', '<Leader>sT', function() builtin.treesitter(dropdown) end, '[S]earch [T]reesitter')
  map('n', '<Leader>sc', function() builtin.commands_history(dropdown) end, '[S]earch [C]ommands history')

  -- Projects
  map('n', '<Leader>sp', telescope.extensions.projects.projects, '[S]earch [P]rojects')

  -- Neoclip
  map({ 'n', 'i' }, '<M-y>', telescope.extensions.neoclip.default, 'Search Yanks')
  map('n', '<Leader>sm', telescope.extensions.macroscope.default, '[S]earch [M]acros')
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

  vim.cmd [[autocmd User TelescopePreviewerLoaded setlocal wrap]]
end

return M
