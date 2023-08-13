local M = {}

function M.format()
  local buf = vim.api.nvim_get_current_buf()
  local formatters = M.get_formatters(buf)
  local client_ids = vim.tbl_map(function(client)
    return client.id
  end, formatters)

  if #client_ids == 0 then
    return
  end

  vim.lsp.buf.format({
    bufnr = buf,
    filter = function(client)
      return vim.tbl_contains(client_ids, client.id)
    end,
  })
end

-- Gets all lsp clients that support formatting.
-- When a null-ls formatter is available for the current filetype,
-- only null-ls formatters are returned.
function M.get_formatters(bufnr)
  local ft = vim.bo[bufnr].filetype
  local ret = {}

  ---@type lsp.Client[]
  local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
  for _, client in ipairs(clients) do
    if M.supports_format(client) then
      table.insert(ret, client)
    end
  end

  return ret
end

-- Gets all lsp clients that support formatting
-- and have not disabled it in their client config
---@param client lsp.Client
function M.supports_format(client)
  if
      client.config
      and client.config.capabilities
      and client.config.capabilities.documentFormattingProvider == false
  then
    return false
  end

  return client.supports_method("textDocument/formatting")
      or client.supports_method("textDocument/rangeFormatting")
end

function M.setup()
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("lsp_format", {}),
    callback = M.format,
  })

  vim.api.nvim_create_user_command('Format', M.format, { desc = 'Format current buffer with LSP' })
end

return M
