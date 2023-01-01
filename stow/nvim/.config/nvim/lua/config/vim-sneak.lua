local M = {}

function M.setup()
  vim.keymap.set('', 's', '<Plug>Sneak_s', { remap = true })
  vim.keymap.set('', 'S', '<Plug>Sneak_S', { remap = true })
  vim.keymap.set('', 'f', '<Plug>Sneak_f', { remap = true })
  vim.keymap.set('', 'F', '<Plug>Sneak_F', { remap = true })
  vim.keymap.set('', 't', '<Plug>Sneak_t', { remap = true })
  vim.keymap.set('', 'T', '<Plug>Sneak_T', { remap = true })
end

return M
