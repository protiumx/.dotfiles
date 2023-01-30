local M = {}

function M.setup()
  local function map(mode, l, r, desc)
    local opts = { silent = true, desc = desc }
    vim.keymap.set(mode, l, r, opts)
  end

  map('n', '<C-g>d', '<cmd>DiffviewOpen -- %<CR>', 'Open Diffview current file')
  map('n', '<M-S-D>', '<cmd>DiffviewOpen<CR>', 'Open Diffview HEAD')
  map('n', '<C-g>H', '<cmd>DiffviewHistory %<CR>', 'Open Diffview history current file')

  local actions = require('diffview.actions')
  require('diffview').setup({
    file_panel = {
      win_config = { -- See ':h diffview-config-win_config'
        position = 'left',
        width = 40,
      },
    },

    file_history_panel = {
      win_config = { -- See ':h diffview-config-win_config'
        position = 'left',
        height = 40,
      },
    },

    keymaps = {
      view = {
        { 'n', '<C-o>', actions.goto_file_tab, { desc = 'Open the file in a new tabpage' } },
        { 'n', '<Leader>P', actions.focus_files, { desc = 'Bring focus to the file panel' } },
        { 'n', '<Leader>p', actions.toggle_files, { desc = 'Toggle the file panel.' } },
      },

      file_panel = {
        { 'n', '<C-o>', actions.goto_file_tab, { desc = 'Open the file in a new tabpage' } },
        { 'n', '<Leader>P', actions.focus_files, { desc = 'Bring focus to the file panel' } },
        { 'n', '<Leader>p', actions.toggle_files, { desc = 'Toggle the file panel' } },
        { 'n', 'q', '<cmd>DiffviewClose<CR>', { silent = true } },
      },

      file_history_panel = {
        { 'n', '<C-o>', actions.goto_file_tab, { desc = 'Open the file in a new tabpage' } },
        { 'n', '<Leader>P', actions.focus_files, { desc = 'Bring focus to the file panel' } },
        { 'n', '<Leader>p', actions.toggle_files, { desc = 'Toggle the file panel' } },
        { 'n', 'q', '<cmd>DiffviewClose<CR>', { silent = true } },
      },
    },
  })
end

return M
