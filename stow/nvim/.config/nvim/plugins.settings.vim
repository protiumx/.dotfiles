
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

nnoremap <F9> :UndotreeToggle<CR>

" NERDCommenter
nmap <C-_> <Plug>NERDCommenterToggle
vmap <C-_> <Plug>NERDCommenterToggle<CR>gv
nmap <C-/> <Plug>NERDCommenterToggle
vmap <C-/> <Plug>NERDCommenterToggle<CR>gv

" Go syntax highlighting
let g:go_highlight_fields = 1
let g:go_highlight_functions = 0
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1

" Emmet
let g:user_emmet_leader_key='<C-X>'

