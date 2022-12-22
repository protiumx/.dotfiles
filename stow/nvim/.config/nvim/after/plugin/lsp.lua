local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
  'tsserver',
  'eslint',
  'sumneko_lua',
  'rust_analyzer',
  'gopls',
  'clangd',
  'pyright',
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
local luasnip = require('luasnip')
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
  ['<C-Space>'] = cmp.mapping.complete(),
  ['<C-d>'] = cmp.mapping.scroll_docs(-4),
  ['<C-f>'] = cmp.mapping.scroll_docs(4),
  ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
})

lsp.set_preferences({
  sign_icons = { }
})

lsp.setup_nvim_cmp({
  mapping = cmp_mappings,
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
})

lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr }

  if client.name == 'eslint' then
      vim.cmd.LspStop('eslint')
      return
  end

  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<Leader>vws', vim.lsp.buf.workspace_symbol, opts)
  vim.keymap.set('n', '<Leader>vd', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', '<Leader>vca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, opts)

  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })

  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_set_hl(0, 'LspReferenceRead', { fg = '#fe5186' })
    vim.api.nvim_set_hl(0, 'LspReferenceText', { fg = '#fe5186' })
    vim.api.nvim_set_hl(0, 'LspReferenceWrite', { fg = '#fe5186' })

    vim.api.nvim_create_augroup('lsp_document_highlight', {})
    vim.api.nvim_create_autocmd('CursorHold', {
      group = 'lsp_document_highlight',
      buffer = 0,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({'CursorMoved', 'CursorMovedI'}, {
      group = 'lsp_document_highlight',
      buffer = 0,
      callback = vim.lsp.buf.clear_references,
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
