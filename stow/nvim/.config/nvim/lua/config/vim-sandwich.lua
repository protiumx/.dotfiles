local M = {}

function M.setup()
  -- `s` is used for vim-sneak
  vim.keymap.set('n', 'za', '<Plug>(sandwich-add)', { remap = true })
  vim.keymap.set({ 'x', 'o' }, 'sa', '<Plug>(sandwich-add)', { remap = true })

  vim.keymap.set('n', 'zdb', '<Plug>(sandwich-delete-auto)', { remap = true })
  vim.keymap.set({ 'x', 'o' }, 'sd', '<Plug>(sandwich-delete)', { remap = true })

  vim.keymap.set('n', 'zrb', '<Plug>(sandwich-replace-auto)', { remap = true })
  vim.keymap.set({ 'x', 'o' }, 'sr', '<Plug>(sandwich-replace)', { remap = true })

  -- Additional text objects e.g. viss to select inner text with auto detection
  -- of surroundings
  vim.keymap.set('x', 'is', '<Plug>(textobj-sandwich-auto-i)', { remap = true })
  vim.keymap.set('x', 'as', '<Plug>(textobj-sandwich-auto-a)', { remap = true })
  vim.keymap.set('o', 'is', '<Plug>(textobj-sandwich-auto-i)', { remap = true })
  vim.keymap.set('o', 'as', '<Plug>(textobj-sandwich-auto-a)', { remap = true })
  -- For specific chars, e.g. im_
  vim.keymap.set('x', 'it', '<Plug>(textobj-sandwich-literal-query-i)', { remap = true })
  vim.keymap.set('x', 'at', '<Plug>(textobj-sandwich-literal-query-a)', { remap = true })
  vim.keymap.set('o', 'it', '<Plug>(textobj-sandwich-literal-query-i)', { remap = true })
  vim.keymap.set('o', 'at', '<Plug>(textobj-sandwich-literal-query-a)', { remap = true })
end

return M
