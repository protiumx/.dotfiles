return {
  'mfussenegger/nvim-dap',
  event = 'VeryLazy',
  dependencies = {
    'theHamsta/nvim-dap-virtual-text',
    'nvim-neotest/nvim-nio',
    'rcarriga/nvim-dap-ui',
  },
  config = function()
    require('plugins.nvim-dap.config')()
  end,
}
