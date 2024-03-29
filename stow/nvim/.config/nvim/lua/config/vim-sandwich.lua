local M = {}

function M.setup()
  vim.g.sandwich_no_default_key_mappings = true
  vim.cmd([[
    call operator#sandwich#set('all', 'all', 'highlight', 1)
  ]])

  -- `s` is used for vim-sneak
  vim.keymap.set('n', '<M-s>a', '<Plug>(sandwich-add)', { remap = true })
  vim.keymap.set({ 'x', 'o', 'v' }, 'sa', '<Plug>(sandwich-add)', { remap = true })

  vim.keymap.set('n', '<M-s>d', '<Plug>(sandwich-delete)', { remap = true })
  vim.keymap.set({ 'x', 'o', 'v' }, 'sd', '<Plug>(sandwich-delete)', { remap = true })

  vim.keymap.set('n', '<M-s>r', '<Plug>(sandwich-replace-auto)', { remap = true })
  vim.keymap.set({ 'x', 'o', 'v' }, 'sr', '<Plug>(sandwich-replace)', { remap = true })

  vim.keymap.set('x', 'is', '<Plug>(textobj-sandwich-query-i)', { remap = true })
  vim.keymap.set('x', 'as', '<Plug>(textobj-sandwich-query-a)', { remap = true })
  vim.keymap.set('o', 'is', '<Plug>(textobj-sandwich-query-i)', { remap = true })
  vim.keymap.set('o', 'as', '<Plug>(textobj-sandwich-query-a)', { remap = true })

  -- Additional text objects e.g. via to select inner text with auto detection
  -- of surroundings
  vim.keymap.set('x', 'ia', '<Plug>(textobj-sandwich-auto-i)', { remap = true })
  vim.keymap.set('x', 'aa', '<Plug>(textobj-sandwich-auto-a)', { remap = true })
  vim.keymap.set('o', 'ia', '<Plug>(textobj-sandwich-auto-i)', { remap = true })
  vim.keymap.set('o', 'aa', '<Plug>(textobj-sandwich-auto-a)', { remap = true })
  -- User specif surrounds e.g. cim_ deletes text surrounded by _
  vim.keymap.set('x', 'im', '<Plug>(textobj-sandwich-literal-query-i)', { remap = true })
  vim.keymap.set('o', 'im', '<Plug>(textobj-sandwich-literal-query-i)', { remap = true })
  vim.keymap.set('x', 'am', '<Plug>(textobj-sandwich-literal-query-a)', { remap = true })
  vim.keymap.set('o', 'am', '<Plug>(textobj-sandwich-literal-query-a)', { remap = true })
end

return M
