local M = {}

local function keymaps()
  local telescope = require('telescope')
  local builtin = require('telescope.builtin')
  local previewers = require('telescope.previewers')
  local themes = require('telescope.themes')

  local delta = previewers.new_termopen_previewer {
    get_command = function(entry)
      -- this is for status
      -- You can get the AM things in entry.status. So we are displaying file if entry.status == '??' or 'A '
      -- just do an if and return a different command
      if entry.status == '??' or 'A ' then
        return { 'git', 'diff', entry.value }
      end

      -- note we can't use pipes
      -- this command is for git_commits and git_bcommits
      return { 'git', 'diff', entry.value .. '^!' }

    end
  }

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

  map({ 'i', 'n' }, '<C-]>', function()
    builtin.find_files(dropdown)
  end, 'Find files')

  map({ 'n' }, '<C-h>', builtin.find_files, 'Find files with preview')

  map({ 'i', 'n' }, '<C-b>', function()
    builtin.buffers(dropdown)
  end, 'Find buffers')

  -- Open in current file's folder
  map('n', '<M-g>', function()
    telescope.extensions.file_browser.file_browser(opts_file_browser_path)
  end, 'Browse files relative')

  map('n', '<M-f>', function()
    telescope.extensions.file_browser.file_browser(opts_file_browser)
  end, 'Browse files')

  map('n', '<Leader>sg', builtin.live_grep, '[S]earch [G]rep')

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
    builtin.spell_suggest(themes.get_cursor())
  end, { silent = true })

  -- Show git diff
  vim.keymap.set('n', '<Leader>sGs', function()
    builtin.git_status({ previewer = delta, layout_strategy = 'vertical' })
  end, { silent = true })
  vim.keymap.set('n', '<Leader>sGb', builtin.git_branches, { silent = true })
  vim.keymap.set('n', '<Leader>sGh', builtin.git_bcommits, { silent = true })
  vim.keymap.set('n', '<Leader>sGc', builtin.git_commits, { silent = true })

  vim.keymap.set('n', '<Leader>sd', builtin.diagnostics, { silent = true, desc = '[S]earch [D]iagnostics' })
  vim.keymap.set('n', '<Leader>sR', builtin.resume, { silent = true, desc = '[S]earch [R]esume' })
  vim.keymap.set('n', '<Leader>sT', function()
    builtin.treesitter(dropdown)
  end, { silent = true, desc = '[S]earch [T]reesitter' })
  vim.keymap.set('n', '<Leader>sc', function()
    builtin.commands_history(dropdown)
  end, { silent = true, desc = '[S]earch [R]esume' })

  -- Projects
  vim.keymap.set('n', '<Leader>sp', function()
    require('telescope').extensions.projects.projects({})
  end, { silent = true, desc = '[S]earch [P]rojects' })

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

  vim.cmd [[autocmd User TelescopePreviewerLoaded setlocal wrap]]
end

return M
