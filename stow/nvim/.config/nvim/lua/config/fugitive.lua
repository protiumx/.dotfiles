local M = {}

function M.setup()
  vim.keymap.set('n', '<Leader>gc', ':G commit<CR>', { silent = true })
  vim.keymap.set('n', '<Leader>gs', ':G stage %<CR>', { silent = true })
end

return M
