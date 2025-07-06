local M = {}

function M.setup()
  local utils = require('config.utils')
  if utils.is_git_commit() then
    return
  end

  require('config.autocmd')
  require('config.term').setup()
  require('config.lsp').setup()
end

return M
