lua << EOF
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<C-q>"] = "delete_buffer"
      },
    },
    file_ignore_patterns = { "node_modules/", ".git/", ".yarn/" },
  }
}
-- require('telescope').load_extension('media_files')
EOF

nnoremap <Leader>ff <cmd>Telescope find_files find_command=rg,--files,--hidden<CR>
" open in current file pwd
nnoremap <Leader>fg <cmd>Telescope live_grep find_command=rg,--line-number,--column,--hidden,--smart-case<CR>
nnoremap <Leader>fG <cmd>Telescope grep_string<CR>
nnoremap <Leader>fr :lua require('telescope.builtin').registers()<CR>
nnoremap <Leader>fb <cmd>Telescope buffers<CR>
" display help tags for all extensions
nnoremap <Leader>fh <cmd>Telescope help_tags<CR>
nnoremap <Leader>fk :lua require('telescope.builtin').keymaps()<CR>
nnoremap <Leader>fz :lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>
nnoremap <Leader>ft :lua require('telescope.builtin').colorscheme()<CR>
" Show diff
nnoremap <Leader>fs :lua require('telescope.builtin').git_status()<CR>
