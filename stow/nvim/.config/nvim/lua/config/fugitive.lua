local M = {}

function M.setup()
  vim.keymap.set('n', '<Leader>Gc', ':G commit<CR>', { silent = true })
  vim.keymap.set('n', '<Leader>Gs', ':G stage %<CR>', { silent = true })
end

return M
