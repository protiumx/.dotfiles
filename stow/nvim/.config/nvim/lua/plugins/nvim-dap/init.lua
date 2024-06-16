return {
  'mfussenegger/nvim-dap',
  cmd = 'DapContinue',
  dependencies = {
    'theHamsta/nvim-dap-virtual-text',
    'nvim-neotest/nvim-nio',
    'rcarriga/nvim-dap-ui',
  },
  config = function()
    require('plugins.nvim-dap.config')()
  end,
}
