local colors = require('config.colors')
local icons = require('config.icons').lsp

local function on_lsp_attach(args, bufnr)
  require('config.lsp.keymaps').setup(bufnr)

  local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

  -- diagnostic open float on cursor hold:
  vim.api.nvim_create_augroup('lsp_diagnostic_hold', { clear = true })
  vim.api.nvim_create_autocmd('CursorHold', {
    group = 'lsp_diagnostic_hold',
    buffer = bufnr,
    callback = function()
      vim.diagnostic.open_float({
        bufnr = bufnr,
        focus = false,
        border = 'single',
        scope = 'line',
        severity = { vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARN },
      })
    end,
  })

  -- document references highlight
  if client:supports_method('textDocument/documentHighlight', args.buf) then
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
  -- diagnostics config
  config = {
    virtual_text = {
      spacing = 1,
      format = function(_)
        -- Just show the sign, no text
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
  },
}

local function setup_lsp()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

  -- Better completion config
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

  vim.lsp.config('*', {
    capabilities = capabilities,
    root_markers = { '.git' },
  })

  local servers = {
    'bashls',
    'clangd',
    'dockerls',
    'gopls',
    'luals',
    'pyrigth',
    'rust_analyzer',
    'yamlls',
  }

  if jit.os ~= 'OSX' then
    table.insert(servers, 'elixirls')
    table.insert(servers, 'ocamllsp')
  end

  for _, server in ipairs(servers) do
    vim.lsp.enable(server)
  end
end

local function setup_icons()
  vim.lsp.set_log_level('error')
  vim.fn.sign_define('DiagnosticSignError', { text = icons.error, texthl = 'DiagnosticSignError' })
  vim.fn.sign_define('DiagnosticSignWarn', { text = icons.warn, texthl = 'DiagnosticSignWarn' })
  vim.fn.sign_define('DiagnosticSignInfo', { text = icons.info, texthl = 'DiagnosticSignInfo' })
  vim.fn.sign_define('DiagnosticSignHint', { text = icons.hint, texthl = 'DiagnosticSignHint' })
end

function M.setup()
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

  setup_lsp()
  setup_icons()
  vim.diagnostic.config(M.config)
  vim.api.nvim_create_autocmd('LspAttach', {
    callback = on_lsp_attach,
  })
end

return M
