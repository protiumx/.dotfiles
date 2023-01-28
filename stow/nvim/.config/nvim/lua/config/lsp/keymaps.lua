local M = {}

function M.setup(bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = '[LSP] ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('gd', vim.lsp.buf.definition, 'go to definitions')
  nmap('gy', vim.lsp.buf.type_definition, 'show type definition')
  nmap('gi', vim.lsp.buf.implementation, 'go to implementation')
  nmap('[d', vim.diagnostic.goto_next, 'go to next diagnostic symbols')
  nmap(']d', vim.diagnostic.goto_prev, 'go to prev diagnostic symbols')
end

return M
