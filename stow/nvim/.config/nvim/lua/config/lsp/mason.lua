local M = {}

-- https://github.com/neovim/nvim-lspconfig/issues/115#issuecomment-902680058
local function organize_go_imports(timeoutms)
  local params = vim.lsp.util.make_range_params()
  params.context = { only = { 'source.organizeImports' } }
  local result = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params, timeoutms)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit, 'UTF-8')
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end
end

local function setup_autocmd(client)
  require('config.lsp.format').setup()

  if client.name == 'gopls' then
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = 'lsp_format',
      pattern = '*.go',
      callback = function()
        -- organize_go_imports(500)
        -- use go.nvim
        require('go.format').goimport()
      end
    })
  end
end

local on_lsp_attach = function(client, bufnr)
  require('config.lsp.keymaps').setup(bufnr)
  setup_autocmd(client)

  if client.name == "yamlls" then
    client.server_capabilities.documentFormattingProvider = true
  end

  local colors = require('config.colors')
  vim.api.nvim_create_augroup('lsp_diagnostic_hold', { clear = true })
  vim.api.nvim_create_autocmd('CursorHold', {
    group = 'lsp_diagnostic_hold',
    buffer = bufnr,
    callback = function()
      vim.diagnostic.open_float({ bufnr = bufnr, focus = false, border = 'single' })
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

  mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
  }

  mason_lspconfig.setup_handlers {
    function(server_name)
      require('lspconfig')[server_name].setup {
        capabilities = capabilities,
        settings = servers[server_name],
        on_attach = on_lsp_attach,
      }
    end,
  }
end

return M
