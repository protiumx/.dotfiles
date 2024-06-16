return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lua',
    'f3fora/cmp-spell',
    'saadparwaiz1/cmp_luasnip',
    require('plugins.luasnip'),
  },
  config = function()
    require('plugins.nvim-cmp.config')()
  end,
}
