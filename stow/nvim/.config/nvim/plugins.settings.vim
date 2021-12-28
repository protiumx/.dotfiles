
let g:PaperColor_Theme_Options = {
      \   'theme': {
      \      'default.dark': {
      \         'override' : {
      \            'color00' : ['#080808', '232'],
      \            'color07': ['#eeeeee', '255'],
      \            'linenumber_bg' : ['#080808', '232']
      \          }
      \        }
      \      }
      \    }

lua << EOF
local opts = {
  auto_session_enabled = true,
}

require('auto-session').setup(opts)

require("project_nvim").setup {
  patterns = { ".git", "package.json" },
  show_hidden = true,
}
EOF

let g:floaterm_keymap_toggle = '<F12>'

nnoremap <F9> :UndotreeToggle<CR>

" [preservim/tagbar] map F8 to CTagbar
nmap <F8> :TagbarToggle<CR>

" NERDCommenter {
nmap <C-_> <Plug>NERDCommenterToggle
vmap <C-_> <Plug>NERDCommenterToggle<CR>gv
nmap <C-/> <Plug>NERDCommenterToggle
vmap <C-/> <Plug>NERDCommenterToggle<CR>gv
" }

"Spelling {
"let g:enable_spelunker_vim = 1
"let g:enable_spelunker_vim_on_readonly = 1
"let g:spelunker_max_suggest_words = 5
"override highlight setting.
"highlight SpelunkerSpellBad cterm=undercurl ctermfg=165 gui=undercurl guifg=#af5fff
"highlight SpelunkerComplexOrCompoundWord cterm=undercurl ctermfg=None gui=undercurl guifg=#af5fff
"let g:spelunker_white_list_for_user = ['grpc', 'uuid']
"Disable URI checking. (default: 0)
"let g:spelunker_disable_uri_checking = 1

"command! -nargs=0 CheckSpell call spelunker#check()
" }

" Go syntax highlighting {
let g:go_highlight_fields = 1
let g:go_highlight_functions = 0
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
" }
