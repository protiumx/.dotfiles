local M = {}

local function run_file()
  local pickers = require('config.telescope.pickers')
  local dap = require('dap')

  local picker_co = coroutine.create(function(coro)
    pickers.select_file({}, function(entry)
      coroutine.resume(coro, entry)
    end)
  end)

  local handler_co = coroutine.create(function()
    local co = coroutine.running()
    coroutine.resume(picker_co, co)
    local filename = coroutine.yield()

    local msg = 'Launching ' .. filename
    local ft, _ = vim.filetype.match({ filename = filename })
    vim.notify(msg, vim.log.levels.INFO)
    dap.run({
      type = ft,
      request = 'launch',
      name = msg,
      program = filename,
    })
  end)

  coroutine.resume(handler_co)
end

function M.setup()
  local dap = require('dap')
  local dapui = require('dapui')
  local widgets = require('dap.ui.widgets')

  local map = function(lhs, rhs, fn, desc)
    vim.keymap.set(lhs, rhs, fn, { desc = '[dap] ' .. desc, silent = true })
  end

  -- Pickers
  map({ 'n', 'i' }, '<M-r>', run_file, 'Select golang file to run')
  map({ 'n', 'i' }, '<M-R>', function()
    dap.run({
      type = vim.bo.filetype,
      request = 'launch',
      name = 'Launching ${file}',
      program = '${file}',
    })
  end, 'Select golang fiel to run')

  map({ 'n', 'i' }, '<M-d>c', function()
    dap.run_to_cursor()
  end, 'Run to Cursor')
  map({ 'n', 'i' }, '<M-d>E', function()
    dap.eval(vim.fn.input('[Expression] > '))
  end, 'Evaluate Input')
  map({ 'n', 'i' }, '<M-d>B', function()
    dap.set_breakpoint(vim.fn.input('[Condition] > '))
  end, 'Conditional Breakpoint')
  map({ 'n', 'i' }, '<M-d>b', function()
    dap.toggle_breakpoint()
  end, 'Toggle Breakpoint')
  map({ 'n', 'i' }, '<M-d>q', function()
    dap.disconnect()
  end, 'Disconnect')
  map({ 'n', 'i' }, '<M-d>q', function()
    dap.close()
  end, 'Quit')
  map({ 'n', 'i' }, '<M-d>r', function()
    dap.repl.toggle()
  end, 'Toggle Repl')
  map({ 'n', 'i' }, '<M-d>c', function()
    dap.continue()
  end, '[DAP] continue')
  map({ 'n', 'i' }, '<M-d>x', function()
    dap.terminate()
  end, 'Terminate')
  map({ 'n', 'i' }, '<M-d>si', function()
    dap.step_into()
  end, 'Step Into')
  map({ 'n', 'i' }, '<M-d>su', function()
    dap.step_out()
  end, 'Step Out')
  map({ 'n', 'i' }, '<M-d>so', function()
    dap.step_over()
  end, 'Step Over')
  map({ 'n', 'i' }, '<M-d>sb', function()
    dap.step_back()
  end, 'Step Back')
  -- Value for the expression under the cursor
  map({ 'n', 'i' }, '<M-d>h', require('dap.ui.widgets').hover, 'Hover Variables')
  -- current scopes in a floating window
  map({ 'n', 'i' }, '<M-d>sc', function()
    widgets.centered_float(widgets.scopes)
  end, 'Show scopes')

  -- dapui
  map({ 'n', 'i' }, '<M-d>U', function()
    dapui.toggle()
  end, 'Toggle UI')

  map({ 'n', 'i', 'v' }, '<M-d>e', function()
    dapui.eval()
  end, 'Evaluate')

  map({ 'n', 'i' }, '<M-d>ue', function()
    dapui.set_breakpoint()
  end, 'Set breakpoint')
end

return M
