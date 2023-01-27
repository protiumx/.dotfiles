local M = {}

function M.setup()
  vim.keymap.set('n', '<Leader>Gc', ':G commit', { silent = true })
  vim.keymap.set('n', '<Leader>Gs', ':G stage %', { silent = true })
end

return M
