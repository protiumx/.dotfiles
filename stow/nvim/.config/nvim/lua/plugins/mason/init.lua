return {
  'williamboman/mason.nvim',
  opts = {
    max_concurrent_installers = 2,
  },
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'hrsh7th/cmp-nvim-lsp',
  },
}
