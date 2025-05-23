local colors = require('config.colors')
local icons = require('config.icons').lsp

local clients = {
  'bashls',
  'buf_ls',
  'clangd',
  'dockerls',
  'gopls',
  'luals',
  'marksman',
  'pyright',
  'rust_analyzer',
  'yamlls',
}

if jit.os ~= 'OSX' then
  table.insert(clients, 'elixirls')
  table.insert(clients, 'ocamllsp')
end

local function on_lsp_attach(args, bufnr)
  require('config.lsp.keymaps').setup(bufnr)
  local gopls = require('config.lsp.gopls')

  local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
  -- Disable semantic tokens
  client.server_capabilities.semanticTokensProvider = nil

  -- Load client specific config
  if client.name == 'gopls' then
    gopls.setup(bufnr)
  end

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

local function setup_clients()
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

  for _, server in ipairs(clients) do
    vim.lsp.enable(server)
  end
end

-- Adapted from lspconfig
local function setup_cmds()
  vim.api.nvim_create_user_command('LspRestart', function(info)
    local detach_clients = {}
    local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
    for _, client in ipairs(clients) do
      vim.notify('restarting client: ' .. client.name)
      client:stop()
      if vim.tbl_count(client.attached_buffers) > 0 then
        detach_clients[client.name] = { client, vim.lsp.get_buffers_by_client_id(client.id) }
      end
    end

    local timer = assert(vim.uv.new_timer())
    timer:start(
      500,
      100,
      vim.schedule_wrap(function()
        for client_name, tuple in pairs(detach_clients) do
          local client, attached_buffers = unpack(tuple)
          if client.is_stopped() then
            for _, _ in pairs(attached_buffers) do
              vim.lsp.start(vim.lsp.config[client_name])
            end
            detach_clients[client_name] = nil
          end
        end

        if next(detach_clients) == nil and not timer:is_closing() then
          timer:close()
        end
      end)
    )
  end, {
    desc = 'Manually restart the given language client(s)',
  })

  vim.api.nvim_create_user_command('LspStop', function(info)
    local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })

    for _, client in ipairs(clients) do
      vim.notify('restarting client: ' .. client.name)
      client:stop(true)
    end
  end, {
    desc = 'Manually stops the given language client(s)',
  })

  vim.api.nvim_create_user_command('LspLog', function()
    vim.cmd(string.format('tabnew %s', vim.lsp.get_log_path()))
  end, {
    desc = 'Opens the Nvim LSP client log.',
  })
end

function M.setup()
  vim.lsp.set_log_level('WARN')
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

  setup_clients()
  setup_cmds()
  -- Setup diagnostic icons
  vim.fn.sign_define('DiagnosticSignError', { text = icons.error, texthl = 'DiagnosticSignError' })
  vim.fn.sign_define('DiagnosticSignWarn', { text = icons.warn, texthl = 'DiagnosticSignWarn' })
  vim.fn.sign_define('DiagnosticSignInfo', { text = icons.info, texthl = 'DiagnosticSignInfo' })
  vim.fn.sign_define('DiagnosticSignHint', { text = icons.hint, texthl = 'DiagnosticSignHint' })

  vim.diagnostic.config(M.config)

  vim.api.nvim_create_autocmd('LspAttach', {
    callback = on_lsp_attach,
  })
end

return M
