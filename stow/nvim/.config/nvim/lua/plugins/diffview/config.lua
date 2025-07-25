return function()
  local actions = require('diffview.actions')

  require('diffview').setup({
    default_args = {
      DiffviewOpen = { '--imply-local' },
      DiffviewFileHistory = { '--base=LOCAL' },
    },

    view = {
      default = {
        -- Config for conflicted files in diff views during a merge or rebase.
        layout = 'diff2_horizontal',
        disable_diagnostics = true, -- Temporarily disable diagnostics for conflict buffers while in the view.
        winbar_info = true, -- See ':h diffview-config-view.x.winbar_info'
      },
      merge_tool = {
        layout = 'diff3_mixed',
      },
    },
    file_panel = {
      win_config = {
        -- See ':h diffview-config-win_config'
        position = 'left',
        width = 40,
      },
    },
    file_history_panel = {
      win_config = {
        -- See ':h diffview-config-win_config'
        position = 'top',
        height = 12,
        -- width = 40,
      },
    },
    hooks = {
      diff_buf_read = function()
        vim.opt_local.wrap = false
        vim.opt_local.list = false
        vim.wo.signcolumn = 'no'
      end,
    },
    keymaps = {
      view = {
        { 'n', '<C-o>', actions.goto_file_tab, { desc = 'Open the file in a new tabpage' } },
        { 'n', '<Leader>p', actions.focus_files, { desc = 'Bring focus to the file panel' } },
        { 'n', '<Leader>P', actions.toggle_files, { desc = 'Toggle the file panel.' } },
      },
      file_panel = {
        { 'n', '<C-o>', actions.goto_file_tab, { desc = 'Open the file in a new tabpage' } },
        { 'n', '<Leader>P', actions.focus_files, { desc = 'Bring focus to the file panel' } },
        { 'n', '<Leader>p', actions.toggle_files, { desc = 'Toggle the file panel' } },
        { 'n', 'q', '<cmd>DiffviewClose<CR>', { silent = true } },
        { 'n', '<M-Up>', ':!git push<CR>' },
        { 'n', '<M-Down>', ':!git pull<CR>' },
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
