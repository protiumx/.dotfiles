local M = {}

function M.setup()
  require('config.lsp.mason').setup()
  require('config.lsp.saga').setup()
  require('fidget').setup({
    text = {
      done = "",
    },
    window = {
      blend = 0,
    }
  })

  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    {
      border = 'single',
    }
  )

  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    {
      border = 'single',
    }
  )

  vim.diagnostic.config({
    virtual_text = {
      spacing = 1,
      format = function(_)
        -- just show the sign
        return ''
      end
    },
    float = {
      focusable = false,
      style = 'minimal',
      border = 'single',
      source = 'always',
      header = '',
      prefix = '',
    },
    underline = false,
    severity_sort = true,
    signs = false,
    update_in_insert = false,
  })
end

return M
