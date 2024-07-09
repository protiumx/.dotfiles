return {
  'neovim/nvim-lspconfig',
  ft = {
    'asm',
    'bash',
    'c',
    'cpp',
    'dockerfile',
    'html',
    'go',
    'javascript',
    'json',
    'lua',
    'ocaml',
    'proto',
    'python',
    'rust',
    'sh',
    'sql',
    'terraform',
    'typescript',
    'svelte',
    'yaml',
    'zsh',
  },
  dependencies = {
    require('plugins.mason'),
    require('plugins.fidget'),
    require('plugins.lspsaga'),
    {
      'b0o/schemastore.nvim',
    },
  },

  config = function()
    require('plugins.nvim-lspconfig.config')()
  end,
}
