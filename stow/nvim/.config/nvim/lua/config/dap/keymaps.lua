local M = {}

function M.setup()
  local dap, dapui = require('dap'), require('dapui')

  vim.keymap.set('n', '<Leader>Dc', dap.run_to_cursor, { desc = 'Run to Cursor' })
  vim.keymap.set('n', '<Leader>DE', function()
    dap.eval(vim.fn.input('[Expression] > '))
  end, { desc = 'Evaluate Input' })
  vim.keymap.set('n', '<Leader>DB', function()
    dap.set_breakpoint(vim.fn.input('[Condition] > '))
  end, { desc = 'Conditional Breakpoint' })
  vim.keymap.set('n', '<Leader>DU', dapui.toggle, { desc = 'Toggle UI' })
  vim.keymap.set('n', '<Leader>Dd', dap.disconnect, { desc = 'Disconnect' })
  vim.keymap.set('n', '<Leader>De', dapui.eval, { desc = 'Evaluate' })
  vim.keymap.set('n', '<Leader>Dg', dap.session, { desc = 'Get Session' })
  -- Value for the expression under the cursor
  vim.keymap.set('n', '<Leader>Dh', require('dap.ui.widgets').hover, { desc = 'Hover Variables' })
  -- current scopes in a floating window
  vim.keymap.set('n', '<Leader>DS', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.scopes)
  end, { desc = 'Scopes' })
  vim.keymap.set('n', '<Leader>Dq', dap.close, { desc = 'Quit' })
  vim.keymap.set('n', '<Leader>Dr', dap.repl.toggle, { desc = 'Toggle Repl' })

  vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Start' })
  vim.keymap.set('n', '<F8>', dap.toggle_breakpoint, { desc = 'Toggle Breakpoint' })

  vim.keymap.set('n', '<Leader>Dx', dap.terminate, { desc = 'Terminate' })
  vim.keymap.set('n', '<Leader>Di', dap.step_into, { desc = 'Step Into' })
  vim.keymap.set('n', '<Leader>Du', dap.step_out, { desc = 'Step Out' })
  vim.keymap.set('n', '<Leader>Do', dap.step_over, { desc = 'Step Over' })
  vim.keymap.set('n', '<Leader>Db', dap.step_back, { desc = 'Step Back' })

  vim.keymap.set('v', '<Leader>De', dapui.eval, { desc = 'Evaluate' })
end

return M
