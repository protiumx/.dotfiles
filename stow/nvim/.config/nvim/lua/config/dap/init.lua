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

local function configure_ui()
  local dap = require('dap')
  local dapui = require('dapui')

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

  vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('dap-nvim', { clear = true }),
    pattern = 'dap-repl',
    callback = function()
      require('dap.ext.autocompl').attach()
    end,
  })
end

local function configure_debuggers()
  local dap = require('dap')
  local pickers = require('config.telescope.pickers')

  dap.adapters.go = {
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
      type = 'go',
      name = 'Debug',
      request = 'launch',
      program = '${file}',
    },
    {
      type = 'go',
      name = 'Debug Test',
      request = 'launch',
      mode = 'test',
      program = '${file}',
    },
    {
      type = 'go',
      name = 'Debug Package',
      request = 'launch',
      mode = 'test',
      program = './${relativeFileDirname}',
    },
    {
      type = 'go',
      name = 'Launch File',
      request = 'launch',
      cwd = '${workspaceFolder}',
      program = function()
        return coroutine.create(function(coro)
          pickers.find_file_pattern('*.go', function(entry)
            coroutine.resume(coro, entry)
          end)
        end)
      end,
    },
  }
end

function M.setup()
  configure_symbols()
  configure_ui()
  configure_debuggers()
  require('config.dap.keymaps').setup()
end

return M
