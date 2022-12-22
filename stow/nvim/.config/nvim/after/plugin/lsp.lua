local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
  'tsserver',
  'eslint',
  'sumneko_lua',
  'rust_analyzer',
  'gopls',
})

-- Fix Undefined global 'vim'
lsp.configure('sumneko_lua', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ['<C-Space>'] = cmp.mapping.complete(),
})

lsp.set_preferences({
  sign_icons = { }
})

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  if client.name == 'eslint' then
      vim.cmd.LspStop('eslint')
      return
  end

  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<Leader>vws', vim.lsp.buf.workspace_symbol, opts)
  vim.keymap.set('n', '<Leader>vd', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', '<Leader>vca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, opts)

  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_augroup('lsp_document_highlight', { clear = true })
    vim.api.nvim_clear_autocmds { buffer = bufnr, group = 'lsp_document_highlight' }
    vim.api.nvim_create_autocmd('CursorHold', {
        callback = vim.lsp.buf.document_highlight,
        buffer = bufnr,
        group = 'lsp_document_highlight',
        desc = 'Document Highlight',
    })
    vim.api.nvim_create_autocmd('CursorMoved', {
        callback = vim.lsp.buf.clear_references,
        buffer = bufnr,
        group = 'lsp_document_highlight',
        desc = 'Clear All the References',
    })
  end
end)

lsp.setup()

vim.diagnostic.config({
  virtual_text = true,
})

vim.api.nvim_set_hl(0, 'DiagnosticError' , { fg = '#c4384b' })
vim.api.nvim_set_hl(0, 'DiagnosticWarn' , { fg = '#c4ab39' })
vim.api.nvim_set_hl(0, 'DiagnosticSignHint' , { fg = 'darkgray', bold = true })
vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextHint' , { bg = 'none' })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineError' , { undercurl = true })
vim.api.nvim_set_hl(0, 'DiagnosticFloatingHint' , { bg = 'none' })
vim.api.nvim_set_hl(0, 'DiagnosticFloatingInfo' , { bg = 'none' })
vim.api.nvim_set_hl(0, 'DiagnosticFloatingWarn' , { bg = 'none' })
vim.api.nvim_set_hl(0, 'DiagnosticFloatingError' , { bg = 'none' })
vim.api.nvim_set_hl(0, 'NormalFloat' , { bg = 'none' })
vim.api.nvim_set_hl(0, 'FloatBorder' , { bg = 'none' })

-- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
