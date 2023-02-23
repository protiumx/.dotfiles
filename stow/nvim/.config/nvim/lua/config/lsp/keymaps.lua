local M = {}

function M.setup(bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = '[LSP] ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('gy', vim.lsp.buf.type_definition, 'Show type definition')
  nmap('gi', vim.lsp.buf.implementation, 'Go to implementation')
  nmap('gd', vim.lsp.buf.definition, 'Go to definition')
end

return M
