lua << EOF
require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '-u',
      '--hidden',
      '--iglob',
      '!.git !node_modules'
    },
  }
}
-- require('telescope').load_extension('media_files')
EOF

nnoremap <Leader>ff <cmd>:lua require('telescope.builtin').find_files({ find_command = { 'rg', '--files', '--iglob', '!.git', '--hidden' }, })<cr>
" open in current file pwd
nnoremap <Leader>fc :lua require('telescope.builtin').file_browser({cwd = vim.fn.expand('%:p:h')})
nnoremap <Leader>fg <cmd>Telescope live_grep<cr>
nnoremap <Leader>fr :lua require('telescope.builtin').registers()<CR>
nnoremap <Leader>fb <cmd>Telescope buffers<cr>
" display help tags for all extensions
nnoremap <Leader>fh <cmd>Telescope help_tags<cr>
nnoremap <Leader>fk :lua require('telescope.builtin').keymaps()<CR>
nnoremap <Leader>fz :lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>
nnoremap <Leader>ft :lua require('telescope.builtin').colorscheme()<CR>
