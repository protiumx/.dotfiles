local M = {}

function M.setup(bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('gd', vim.lsp.buf.definition, 'go to definitions')
  nmap('gy', vim.lsp.buf.type_definition, 'show type definition')
  nmap('gi', vim.lsp.buf.implementation, 'go to implementation')
  nmap('gD', vim.lsp.buf.declaration, 'go to declaration')
  nmap('gr', vim.lsp.buf.references, 'show references')
  nmap('K', vim.lsp.buf.hover, 'show help')
  nmap('<Leader>vws', vim.lsp.buf.workspace_symbol, 'show workspace symbols')
  nmap('<Leader>vd', vim.diagnostic.open_float, 'open float')
  nmap('[d', vim.diagnostic.goto_next, 'go to next diagnostic symbols')
  nmap(']d', vim.diagnostic.goto_prev, 'go to prev diagnostic symbols')
end

return M
