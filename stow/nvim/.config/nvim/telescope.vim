lua << EOF
require('telescope').setup{
  defaults = {
    prompt_prefix = "❯ ",
    selection_caret = "❯ ",
    layout_config = { height = 0.95, width = 0.9 },
    mappings = {
      i = {
        ["<C-q>"] = "delete_buffer"
      },
    },

    vimgrep_arguments = {
      "rg",
      "--line-number", 
      "--column", 
      "--hidden", 
      "--smart-case", 
      "-u"
    },

    file_ignore_patterns = { "target/*", "node_modules/*", "^.git/*", "^.yarn/*" },
  },

  pickers = {
    find_files = {
      find_command = { "rg", "--files", "--hidden", "-u" }
    },
  }
}
-- require('telescope').load_extension('media_files')
require('telescope').load_extension('fzf')
require("telescope").load_extension('file_browser')
EOF

nnoremap <silent><Leader>ff <cmd>Telescope find_files previewer=false theme=dropdown<CR>
nnoremap <silent><Leader>fF <cmd>Telescope find_files<CR>
nnoremap <silent><Leader>Ff :exe ':Telescope file_browser grouped=true hidden=true previewer=false theme=dropdown follow=true path=%:p:h cwd='.finddir('.git/..', expand('%:p:h').';')<CR>
nnoremap <silent><Leader>FF :exe ":Telescope file_browser grouped=true hidden=true previewer=false theme=dropdown follow=true cwd=".finddir('.git/..', expand('%:p:h').';')<CR>
" open in current file pwd
nnoremap <silent><Leader>fg <cmd>Telescope live_grep<CR>
" find word under cursor
nnoremap <silent><Leader>fw <cmd>Telescope grep_string<CR>
nnoremap <silent><Leader>fr :lua require('telescope.builtin').registers()<CR>
nnoremap <silent><Leader>fb <cmd>Telescope buffers previewer=false theme=dropdown<CR>
nnoremap <silent><Leader>fh <cmd>Telescope help_tags<CR>
nnoremap <silent><Leader>fk :lua require('telescope.builtin').keymaps()<CR>
nnoremap <silent><Leader>fz :Telescope current_buffer_fuzzy_find theme=dropdown previewer=false<CR>
nnoremap <silent><Leader>ft :lua require('telescope.builtin').colorscheme()<CR>
nnoremap <silent><Leader>fq :lua require('telescope.builtin').quickfix()<CR>
nnoremap <silent><Leader>fS :lua require('telescope.builtin').spell_suggest(require('telescope.themes').get_cursor())<CR>
" Show diff
nnoremap <silent><Leader>fs :lua require('telescope.builtin').git_status()<CR>

autocmd User TelescopePreviewerLoaded setlocal wrap
