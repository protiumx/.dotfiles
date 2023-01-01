local M = {}

function M.setup()
  require('config.lsp.mason').setup()
  require('config.lsp.cmp').setup()

  vim.diagnostic.config({
    virtual_text = {
      spacing = 1,
      format = function(_)
        -- just show the sign
        return ''
      end
    },
    underline = false,
    severity_sort = true,
    signs = false,
  })
end

return M
