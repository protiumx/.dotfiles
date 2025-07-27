local M = {}

function M.setup()
  if vim.g.mini then
    return
  end

  require('config.autocmd')
  require('config.term').setup()
  require('config.lsp').setup()
end

return M
