local M = {}

local on_lsp_attach = function(client, bufnr)
  require('config.lsp.keymaps').setup(bufnr)
  if client.name == 'yamlls' then
    client.server_capabilities.documentFormattingProvider = true
  end

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

function M.setup()
  require('mason').setup({
    max_concurrent_installers = 2,
  })

  local servers = require('config.lsp.servers')

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

  capabilities.textDocument.completion.completionItem = {
    documentationFormat = { 'markdown', 'plaintext' },
    snippetSupport = true,
    preselectSupport = true,
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    deprecatedSupport = true,
    commitCharactersSupport = true,
    tagSupport = { valueSet = { 1 } },
    resolveSupport = {
      properties = {
        'documentation',
        'detail',
        'additionalTextEdits',
      },
    },
  }
  -- Ensure the servers above are installed
  local mason_lspconfig = require('mason-lspconfig')

  mason_lspconfig.setup({
    ensure_installed = vim.tbl_keys(servers),
  })

  mason_lspconfig.setup_handlers({
    function(server_name)
      require('lspconfig')[server_name].setup({
        capabilities = capabilities,
        settings = servers[server_name],
        on_attach = on_lsp_attach,
      })
    end,
  })
end

return M
