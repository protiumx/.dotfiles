return {
  'smoka7/hop.nvim',
  event = 'VeryLazy',
  config = function()
    require('plugins.hop.config')()
  end,
  opts = {},
}
