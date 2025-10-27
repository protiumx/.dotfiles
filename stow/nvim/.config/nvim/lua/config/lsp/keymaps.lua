local M = {}

function M.setup(bufnr)
  local nmap = function(keys, cmd, desc)
    vim.keymap.set('n', keys, cmd, { buffer = bufnr, desc = '[LSP] ' .. desc })
  end

  nmap('gd', vim.lsp.buf.definition, 'Go to definition')
  nmap('<C-l>d', ':vsplit | lua vim.lsp.buf.definition()<CR>', 'Go to definition vertical split')
  nmap(
    '<C-l>i',
    ':vsplit | lua vim.lsp.buf.implementation()<CR>',
    'Go to implementation vertical split'
  )
  nmap('[e', function()
    vim.diagnostic.jump({ count = -1, float = true, severity = vim.diagnostic.severity.ERROR })
  end, 'Go to prev error')
  nmap(']e', function()
    vim.diagnostic.jump({ count = 1, float = true, severity = vim.diagnostic.severity.ERROR })
  end, 'Go to next diagnostic')
  nmap('[d', function()
    vim.diagnostic.jump({ count = -1, float = true })
  end, 'Go to prev diagnostic')
  nmap(']d', function()
    vim.diagnostic.jump({ count = 1, float = true })
  end, 'Go to next error')
  nmap('<C-l>k', vim.lsp.buf.signature_help, 'Show signature help')
  nmap('<C-l>h', vim.lsp.buf.document_highlight, 'Highlight node')
  nmap('<C-l>c', vim.lsp.buf.clear_references, 'Clear highlights')
  nmap('<C-l>y', function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
  end, 'Toggle inlay hints')
  nmap('gh', '<cmd>Telescope lsp_references<CR>', 'References')
  nmap('gH', '<cmd>Telescope lsp_implementations<CR>', 'Implementations')
  nmap('gy', '<cmd>Telescope lsp_type_definitions<CR>', 'Type definitions')
  nmap('gt', vim.lsp.buf.type_definition, 'Type definition')

  -- Comment utils - uses LSP
  vim.keymap.set('n', '<C-_>', 'gcc', { remap = true })
  vim.keymap.set('n', '<C-/>', 'gcc', { remap = true })
  vim.keymap.set('v', '<C-_>', 'gc', { remap = true })
  vim.keymap.set('v', '<C-/>', 'gc', { remap = true })
  vim.keymap.set('i', '<C-/>', '<C-o>gcc', { remap = true })
  vim.keymap.set('i', '<C-_>', '<C-o>gcc', { remap = true })
end

return M
