return {
  setup = function()
    require('config.settings')
    require('config.autocmd')
    require('config.term').setup()
    require('config.lsp').setup()
  end,
}
