local M = {}

function M.setup(bufnr)
  local nmap = function(keys, cmd, desc)
    if cmd == nil then
      return
    end

    vim.keymap.set('n', keys, cmd, { buffer = bufnr, desc = '[LSP] ' .. desc })
  end

  nmap('gd', vim.lsp.buf.definition, 'Go to definition')
  nmap('<C-l>dv', ':vsplit | lua vim.lsp.buf.definition()<CR>', 'Go to definition vertical split')
  nmap('gt', vim.lsp.buf.type_definition, 'Show type definition')
  nmap('gy', vim.lsp.buf.implementation, 'Go to implementation')
  nmap(
    '<C-l>dv',
    ':vsplit | lua vim.lsp.buf.implementation()<CR>',
    'Go to implementation vertical split'
  )
  nmap('gR', vim.lsp.buf.references, 'Go to references')
  nmap('gd', '<cmd>lua vim.lsp.buf.definition()<CR>zz', 'Go to definition')
  nmap('[e', function()
    vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
  end, 'Go to prev error')
  nmap(']e', function()
    vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
  end, 'Go to next diagnostic')
  nmap('[d', function()
    vim.diagnostic.goto_prev()
  end, 'Go to prev diagnostic')
  nmap(']d', function()
    vim.diagnostic.goto_next()
  end, 'Go to next error')
  nmap('<C-l>k', vim.lsp.buf.signature_help, 'Show signature help')
  nmap('<C-l>h', vim.lsp.buf.document_highlight, 'Highlight node')
  nmap('<C-l>c', vim.lsp.buf.clear_references, 'Clear highlights')
  nmap('<C-l>y', function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
  end, 'Toggle inlay hints')
end

return M
