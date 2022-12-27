-- Project
require('project_nvim').setup({
  detection_methods = { 'pattern' },
  show_hidden = true,
  patterns = { 'go.mod', '.git', 'Makefile', 'package.json', '!.git/worktrees' },
})

vim.g['user_emmet_leader_key'] = '<C-X>'

-- vim sneak
vim.keymap.set('', 's', '<Plug>Sneak_s', { remap = true })
vim.keymap.set('', 'S', '<Plug>Sneak_S', { remap = true })
vim.keymap.set('', 'f', '<Plug>Sneak_f', { remap = true })
vim.keymap.set('', 'F', '<Plug>Sneak_F', { remap = true })
vim.keymap.set('', 't', '<Plug>Sneak_t', { remap = true })
vim.keymap.set('', 'T', '<Plug>Sneak_T', { remap = true })

-- vim align
-- Start interactive EasyAlign in visual mode (e.g. vipga)
vim.keymap.set('x', 'ga', '<Plug>(EasyAlign)', { remap = true })
-- Start interactive EasyAlign for a motion/text object (e.g. gaip)
vim.keymap.set('n', 'ga', '<Plug>(EasyAlign)', { remap = true })

-- vim sandwich
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

-- Git status
vim.keymap.set('n', '<F3>', function()
  local name = vim.fn.bufname('fugitive:///*/.git//')
  if name ~= '' and vim.fn.buflisted(name) ~= 0 then
    vim.cmd [[ execute ":bd" bufname('fugitive:///*/.git//') ]]
  else
    vim.cmd [[vertical Git | vertical resize 40 | setlocal noequalalways wrap readonly nomodifiable noswapfile]]
  end
end)
