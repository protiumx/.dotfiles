let g:PaperColor_Theme_Options = {
      \   'theme': {
      \      'default.dark': {
      \         'override' : {
      \            'color07': ['#eeeeee', ''],
      \            'linenumber_bg' : ['#212121', '']
      \          }
      \        }
      \      }
      \    }

nnoremap <F9> :UndotreeToggle<CR>

" NERDCommenter
let g:NERDCreateDefaultMappings = 0
nmap <C-_> <Plug>NERDCommenterToggle
vmap <C-_> <Plug>NERDCommenterToggle<CR>gv
nmap <C-/> <Plug>NERDCommenterToggle
vmap <C-/> <Plug>NERDCommenterToggle<CR>gv
imap <C-/> <Plug>NERDCommenterInsert
imap <C-_> <Plug>NERDCommenterInsert

let g:gruvbox_contrast = 'hard'
let g:gruvbox_sign_column = 'bg0'

" Go syntax highlighting
"let g:go_highlight_fields = 1
"let g:go_highlight_functions = 0
"let g:go_highlight_function_calls = 1
"let g:go_highlight_extra_types = 1
"let g:go_highlight_operators = 1

" Emmet
let g:user_emmet_leader_key='<C-X>'

