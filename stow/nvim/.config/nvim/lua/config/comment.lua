local M = {}

function M.setup()
  require('Comment').setup({
    -- ignore empty lines
    ignore = '^$',
  })

  vim.keymap.set('n', '<C-_>', '<Plug>(comment_toggle_linewise_current)', { remap = true })
  vim.keymap.set('n', '<C-/>', '<Plug>(comment_toggle_linewise_current)', { remap = true })
  vim.keymap.set('v', '<C-_>', '<Plug>(comment_toggle_linewise_visual)', { remap = true })
  vim.keymap.set('v', '<C-/>', '<Plug>(comment_toggle_linewise_visual)', { remap = true })
  vim.keymap.set('i', '<C-/>', '<C-o><Plug>(comment_toggle_linewise_current)', { remap = true })
  vim.keymap.set('i', '<C-_>', '<C-o><Plug>(comment_toggle_linewise_current)', { remap = true })
end

return M
