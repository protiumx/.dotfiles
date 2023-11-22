local dap = require('dap')
local dapui = require('dapui')

local M = {}

local function configure_symbols()
  local dap_breakpoint = {
    breakpoint = {
      text = '',
      texthl = 'LspDiagnosticsSignError',
      linehl = '',
      numhl = '',
    },

    rejected = {
      text = '',
      texthl = 'LspDiagnosticsSignHint',
      linehl = '',
      numhl = '',
    },

    conditional = {
      text = '',
      texthl = 'LspDiagnosticsSignHint',
      linehl = '',
      numhl = '',
    },

    log = {
      text = '󱁼',
      texthl = 'LspDiagnosticsSignHint',
      linehl = '',
      numhl = '',
    },

    stopped = {
      text = '',
      texthl = 'LspDiagnosticsSignInformation',
      linehl = 'DiagnosticUnderlineInfo',
      numhl = 'LspDiagnosticsSignInformation',
    },
  }

  vim.fn.sign_define('DapBreakpoint', dap_breakpoint.breakpoint)
  vim.fn.sign_define('DapBreakpointCondition', dap_breakpoint.conditional)
  vim.fn.sign_define('DapStopped', dap_breakpoint.stopped)
  vim.fn.sign_define('DapLogPoint', dap_breakpoint.log)
  vim.fn.sign_define('DapBreakpointRejected', dap_breakpoint.rejected)
end

local function configure_exts()
  require('nvim-dap-virtual-text').setup({
    commented = true,
  })

  dapui.setup({}) -- use default

  dap.listeners.after.event_initialized['dapui_config'] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated['dapui_config'] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited['dapui_config'] = function()
    dapui.close()
  end
end

local function configure_debuggers()
  dap.adapters.delve = {
    type = 'server',
    port = '${port}',
    executable = {
      command = 'dlv',
      args = { 'dap', '-l', '127.0.0.1:${port}' },
    },
  }

  -- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
  dap.configurations.go = {
    {
      type = 'delve',
      name = 'Debug Go',
      request = 'launch',
      program = '${file}',
    },
    {
      type = 'delve',
      name = 'Debug Go test', -- configuration for debugging test files
      request = 'launch',
      mode = 'test',
      program = '${file}',
    },
    -- works with go.mod packages and sub packages
    {
      type = 'delve',
      name = 'Debug Go test (go.mod)',
      request = 'launch',
      mode = 'test',
      program = './${relativeFileDirname}',
    },
  }
end

function M.setup()
  configure_symbols()
  configure_exts()
  configure_debuggers()
  require('config.dap.keymaps').setup()
end

return M
