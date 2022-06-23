nmap s <Nop>
xmap s <Nop>

lua << EOF
require("colorizer").setup()
require('gitsigns').setup()
require('Comment').setup()
EOF

"let g:PaperColor_Theme_Options = {
      "\   'theme': {
      "\      'default.dark': {
      "\         'override' : {
      "\            'color07': ['#eeeeee', ''],
      "\            'linenumber_bg' : ['#212121', '']
      "\          }
      "\        }
      "\      }
      "\    }

nnoremap <F9> :UndotreeToggle<CR>

" Comment
nmap <C-_> <CMD>lua require("Comment.api").toggle_current_linewise()<CR>
nmap <C-/> <CMD>lua require("Comment.api").toggle_current_linewise()<CR>
vmap <C-_> <ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>
vmap <C-/> <ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>
imap <C-/> <ESC><CMD>lua require("Comment.api").toggle_current_linewise()<CR> 
imap <C-_> <ESC><CMD>lua require("Comment.api").toggle_current_linewise()<CR> 

"let g:gruvbox_contrast = 'hard'
"let g:gruvbox_sign_column = 'bg0'

" Go syntax highlighting
"let g:go_highlight_fields = 1
"let g:go_highlight_functions = 0
"let g:go_highlight_function_calls = 1
"let g:go_highlight_extra_types = 1
"let g:go_highlight_operators = 1

" Emmet
let g:user_emmet_leader_key='<C-X>'

" Vim Sneak
nmap z <Plug>Sneak_s
nmap Z <Plug>Sneak_S
" visual-mode
xmap z <Plug>Sneak_s
xmap Z <Plug>Sneak_S
" operator-pending-mode
omap z <Plug>Sneak_s
omap Z <Plug>Sneak_S
