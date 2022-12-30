local M = {}

function M.setup()
  vim.keymap.set('n', '<Leader>Dc', "<cmd>lua require'dap'.run_to_cursor()<cr>", { desc = 'Run to Cursor' })
  vim.keymap.set('n', '<Leader>DE', "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>",
    { desc = 'Evaluate Input' })
  vim.keymap.set('n', '<Leader>DB', "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>",
    { desc = 'Conditional Breakpoint' })
  vim.keymap.set('n', '<Leader>DU', "<cmd>lua require'dapui'.toggle()<cr>", { desc = 'Toggle UI' })
  vim.keymap.set('n', '<Leader>Dd', "<cmd>lua require'dap'.disconnect()<cr>", { desc = 'Disconnect' })
  vim.keymap.set('n', '<Leader>De', "<cmd>lua require'dapui'.eval()<cr>", { desc = 'Evaluate' })
  vim.keymap.set('n', '<Leader>Dg', "<cmd>lua require'dap'.session()<cr>", { desc = 'Get Session' })
  vim.keymap.set('n', '<Leader>Dh', "<cmd>lua require'dap.ui.widgets'.hover()<cr>", { desc = 'Hover Variables' })
  vim.keymap.set('n', '<Leader>DS', "<cmd>lua require'dap.ui.widgets'.scopes()<cr>", { desc = 'Scopes' })
  vim.keymap.set('n', '<Leader>Dp', "<cmd>lua require'dap'.pause.toggle()<cr>", { desc = 'Pause' })
  vim.keymap.set('n', '<Leader>Dq', "<cmd>lua require'dap'.close()<cr>", { desc = 'Quit' })
  vim.keymap.set('n', '<Leader>Dr', "<cmd>lua require'dap'.repl.toggle()<cr>", { desc = 'Toggle Repl' })

  vim.keymap.set('n', '<F5>', "<cmd>lua require'dap'.continue()<cr>", { desc = 'Start' })
  vim.keymap.set('n', '<F8>', "<cmd>lua require'dap'.toggle_breakpoint()<cr>", { desc = 'Toggle Breakpoint' })

  vim.keymap.set('n', '<Leader>Dx', "<cmd>lua require'dap'.terminate()<cr>", { desc = 'Terminate' })
  vim.keymap.set('n', '<Leader>Di', "<cmd>lua require'dap'.step_into()<cr>", { desc = 'Step Into' })
  vim.keymap.set('n', '<Leader>Du', "<cmd>lua require'dap'.step_out()<cr>", { desc = 'Step Out' })
  vim.keymap.set('n', '<Leader>Do', "<cmd>lua require'dap'.step_over()<cr>", { desc = 'Step Over' })
  vim.keymap.set('n', '<Leader>Db', "<cmd>lua require'dap'.step_back()<cr>", { desc = 'Step Back' })

  vim.keymap.set('v', '<Leader>De', "<cmd>lua require'dapui'.eval()<cr>", { desc = 'Evaluate' })

end

return M
