lua << EOF
require('telescope').setup{
  defaults = {
    layout_config = { height = 0.95, width = 0.9 },
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
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

    file_ignore_patterns = { "node_modules/*", "^.git/*", "^.yarn/*" },
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

nnoremap <silent><Leader>ff <cmd>Telescope find_files<CR>
nnoremap <silent><Leader>Ff <cmd>:lua require('telescope').extensions.file_browser.file_browser(require('telescope.themes').get_dropdown{previewer = false, path='%:p:h', prompt_title=vim.fn.expand('%:h')})<CR>
nnoremap <silent><Leader>FF <cmd>:lua require('telescope').extensions.file_browser.file_browser(require('telescope.themes').get_dropdown{previewer = false})<CR>
" open in current file pwd
nnoremap <silent><Leader>fg <cmd>Telescope live_grep<CR>
nnoremap <silent><Leader>fG <cmd>Telescope grep_string<CR>
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
