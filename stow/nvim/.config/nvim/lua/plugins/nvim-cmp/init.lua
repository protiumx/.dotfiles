return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-nvim-lsp',
    'saadparwaiz1/cmp_luasnip',
    require('plugins.luasnip'),
  },
  config = function()
    require('plugins.nvim-cmp.config')()
  end,
}
