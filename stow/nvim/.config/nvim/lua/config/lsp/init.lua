local M = {}

function M.setup()
  vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
  vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
  vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
  vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })

  vim.lsp.set_log_level('off')

  require('config.lsp.mason').setup()
  require('config.lsp.saga').setup()
  require('fidget').setup({
    align = {
      bottom = false, -- align fidgets along bottom edge of buffer
      right = true,   -- align fidgets along right edge of buffer
    },
    text = {
      done = "",
    },
    window = {
      blend = 0,
    }
  })

  -- NOTE: noice.nvim sets these 2 handlers
  -- vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  --   vim.lsp.handlers.hover,
  --   {
  --     border = 'single',
  --   }
  -- )

  -- vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  --   vim.lsp.handlers.signature_help,
  --   {
  --     border = 'single',
  --   }
  -- )
  --

  vim.diagnostic.config({
    virtual_text = {
      spacing = 1,
      format = function(_)
        -- just show the sign
        return ''
      end
    },
    float = {
      focusable = true,
      source = true,
      boder = 'single',
      header = '',
      prefix = '',
      max_width = 100,
      zindex = 40,
    },
    underline = false,
    severity_sort = true,
    signs = false,
    update_in_insert = true,
  })
end

return M
