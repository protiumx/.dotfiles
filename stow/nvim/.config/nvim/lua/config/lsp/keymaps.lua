local M = {}

function M.setup(bufnr)
  local nmap = function(keys, cmd, desc)
    if cmd == nil then
      return
    end

    vim.keymap.set('n', keys, cmd, { buffer = bufnr, desc = '[LSP] ' .. desc })
  end

  nmap('gd', vim.lsp.buf.definition, 'Go to definition')
  nmap('gv', ':vsplit | lua vim.lsp.buf.definition()<CR>', 'Go to definition vertical split')
  nmap('gy', vim.lsp.buf.type_definition, 'Show type definition')
  nmap('gi', vim.lsp.buf.implementation, 'Go to implementation')
  nmap('gR', vim.lsp.buf.references, 'Go to references')
  -- nmap('gd', '<cmd>lua vim.lsp.buf.definition()<CR>zz', 'Go to definition')
  nmap('[d', vim.diagnostic.goto_prev, 'Go to prev diagnostic')
  nmap(']d', vim.diagnostic.goto_next, 'Go to next diagnostic')
  nmap('[e', function()
    vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
  end, 'Go to prev error')
  nmap(']e', function()
    vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
  end, 'Go to next error')
  nmap('K', vim.lsp.buf.hover, 'Show docs')
  nmap('<C-l>k', vim.lsp.buf.signature_help, 'Show signature help')
  nmap('<C-l>h', vim.lsp.buf.document_highlight, 'Highlight node')
  nmap('<C-l>c', vim.lsp.buf.clear_references, 'Clear highlights')
  nmap('<C-l>q', vim.lsp.buf.setqflist, 'Set quickfix list with diagnostics')
  nmap('<C-l>f', vim.lsp.buf.format, 'Format')
end

return M
