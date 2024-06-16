return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = function()
    pcall(require('nvim-treesitter.install').update({ with_sync = true }))
  end,
  config = function()
    require('plugins.treesitter.config')()
  end,
}
