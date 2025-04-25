local M = {}

function M.setup(bufnr)
  local nmap = function(keys, cmd, desc)
    vim.keymap.set('n', keys, cmd, { buffer = bufnr, desc = '[LSP] ' .. desc })
  end

  nmap('gd', vim.lsp.buf.definition, 'Go to definition')
  nmap('<C-l>d', ':vsplit | lua vim.lsp.buf.definition()<CR>', 'Go to definition vertical split')
  nmap('gt', vim.lsp.buf.type_definition, 'Show type definition')
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

  if jit.os == 'OSX' then
    nmap('gh', '<cmd>Telescope lsp_references<CR>', 'Show signature help')
    nmap('<Leader>ca', vim.lsp.buf.code_action, 'Code Action')
    nmap('gT', vim.lsp.buf.type_definition, 'Type definition')
  end
end

return M
