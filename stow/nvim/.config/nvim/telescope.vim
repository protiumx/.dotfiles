nnoremap <leader>ff <cmd>:lua require('telescope.builtin').find_files({ find_command = { 'rg', '--files', '--iglob', '!.git', '--hidden' }, })<cr>
" open in current file pwd
nnoremap <leader>fc :lua require('telescope.builtin').file_browser({cwd = vim.fn.expand('%:p:h')})
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fr :lua require('telescope.builtin').registers()<CR>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
" display help tags for all extensions
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fk :lua require('telescope.builtin').keymaps()<CR>
nnoremap <leader>fz :lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>
nnoremap <leader>ft :lua require('telescope.builtin').colorscheme()<CR>
