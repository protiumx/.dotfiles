local function on_lsp_attach(client, bufnr)
  require('config.lsp.keymaps').setup(bufnr)

  local colors = require('config.colors')
  vim.api.nvim_create_augroup('lsp_diagnostic_hold', { clear = true })
  vim.api.nvim_create_autocmd('CursorHold', {
    group = 'lsp_diagnostic_hold',
    buffer = bufnr,
    callback = function()
      vim.diagnostic.open_float({
        bufnr = bufnr,
        focus = false,
        border = 'single',
      })
    end,
  })

  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_set_hl(0, 'LspReferenceRead', { fg = colors.accent })
    vim.api.nvim_set_hl(0, 'LspReferenceText', { fg = colors.accent })
    vim.api.nvim_set_hl(0, 'LspReferenceWrite', { fg = colors.accent })

    -- TODO: create command to enable doc Highlight
    -- vim.api.nvim_create_augroup('lsp_document_highlight', { clear = true })
    -- Highlight references only in normal mode
    -- local timer = nil
    -- vim.api.nvim_create_autocmd('CursorHold', {
    --   group = 'lsp_document_highlight',
    --   buffer = bufnr,
    --   callback = function()
    --     timer = vim.defer_fn(function()
    --       vim.lsp.buf.document_highlight()
    --       timer = nil
    --     end, 1000)
    --   end
    -- })

    -- vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
    --   group = 'lsp_document_highlight',
    --   buffer = bufnr,
    --   callback = function()
    --     if timer ~= nil then
    --       timer:stop()
    --       timer = nil
    --     else
    --       vim.lsp.buf.clear_references()
    --     end
    --   end
    -- })
  end
end

local M = {
  on_lsp_attach = on_lsp_attach,
}

function M.setup()
  local icons = require('config.icons').lsp

  vim.lsp.set_log_level('error')
  vim.fn.sign_define('DiagnosticSignError', { text = icons.error, texthl = 'DiagnosticSignError' })
  vim.fn.sign_define('DiagnosticSignWarn', { text = icons.warn, texthl = 'DiagnosticSignWarn' })
  vim.fn.sign_define('DiagnosticSignInfo', { text = icons.info, texthl = 'DiagnosticSignInfo' })
  vim.fn.sign_define('DiagnosticSignHint', { text = icons.hint, texthl = 'DiagnosticSignHint' })

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
      end,
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
