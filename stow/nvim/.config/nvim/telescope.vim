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
      find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" }
    },
  }
}
-- require('telescope').load_extension('media_files')
require('telescope').load_extension('fzf')
require("telescope").load_extension('file_browser')
EOF

inoremap <silent><C-]> <Esc><cmd>Telescope find_files previewer=false theme=dropdown<CR>
nnoremap <silent><C-]> <cmd>Telescope find_files previewer=false theme=dropdown<CR>

inoremap <silent><C-H> <Esc><cmd>Telescope find_files<CR>
nnoremap <silent><C-H> <cmd>Telescope find_files<CR>

inoremap <silent><C-B> <Esc><cmd>Telescope buffers previewer=false theme=dropdown<CR>
nnoremap <silent><C-B> <cmd>Telescope buffers previewer=false theme=dropdown<CR>

nnoremap <silent><Leader><C-]> :exe ':Telescope file_browser grouped=true hidden=true previewer=false theme=dropdown follow=true path=%:p:h cwd='.finddir('.git/..', expand('%:p:h').';')<CR>
nnoremap <silent><Leader><C-H> :exe ":Telescope file_browser grouped=true hidden=true previewer=false theme=dropdown follow=true cwd=".finddir('.git/..', expand('%:p:h').';')<CR>

nnoremap <silent><Leader>fg <cmd>Telescope live_grep<CR>
" find word under cursor

nnoremap <silent><Leader>fw <cmd>Telescope grep_string<CR>
nnoremap <silent><Leader>fr :lua require('telescope.builtin').registers()<CR>
nnoremap <silent><Leader>fh <cmd>Telescope help_tags<CR>
nnoremap <silent><Leader>fk :lua require('telescope.builtin').keymaps()<CR>
nnoremap <silent><Leader>fz :Telescope current_buffer_fuzzy_find theme=dropdown previewer=false<CR>
nnoremap <silent><Leader>ft :lua require('telescope.builtin').colorscheme()<CR>
nnoremap <silent><Leader>fq :lua require('telescope.builtin').quickfix()<CR>
nnoremap <silent><Leader>fS :lua require('telescope.builtin').spell_suggest(require('telescope.themes').get_cursor())<CR>
" Show diff
nnoremap <silent><Leader>fs :lua require('telescope.builtin').git_status()<CR>

autocmd User TelescopePreviewerLoaded setlocal wrap
