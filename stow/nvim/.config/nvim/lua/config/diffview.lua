local M = {}

function M.setup()
  local function map(mode, l, r, desc)
    local opts = { silent = true, desc = desc }
    vim.keymap.set(mode, l, r, opts)
  end

  map('n', '<Leader>gD', '<cmd>DiffviewOpen<CR>', 'Open Diff view')
  map('n', '<Leader>gH', '<cmd>DiffviewHistory %<CR>', 'Open Git history of current file')

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
      file_panel = {
        { 'n', '<C-o>', actions.goto_file_tab, { desc = 'Open the file in a new tabpage' } },
        { 'n', 'gf', actions.goto_file, { desc = 'Open the file in a new split in the previous tabpage' } },
        { 'n', '<Leader>P', actions.focus_files, { desc = 'Bring focus to the file panel' } },
        { 'n', '<Leader>p', actions.toggle_files, { desc = 'Toggle the file panel' } },
        { 'n', 'q', '<cmd>DiffviewClose<CR>', { silent = true } },
      },
    },
  })
end

return M
