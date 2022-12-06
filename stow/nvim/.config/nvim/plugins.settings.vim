" Needed for vim-sandwhich
map s <Nop>
xmap s <Nop>

let g:dbext_default_usermaps = 0

lua require("colorizer").setup()
lua require('Comment').setup()

let g:PaperColor_Theme_Options = {
      \   'theme': {
      \      'default.dark': {
      \         'override' : {
      \            'color07': ['#e3e3e3', ''],
      \          }
      \        }
      \      }
      \    }

nnoremap <F9> :UndotreeToggle<CR>

" Comment
nmap <C-_> <Plug>(comment_toggle_linewise_current)
nmap <C-/> <Plug>(comment_toggle_linewise_current)
vmap <C-_> <Plug>(comment_toggle_linewise_visual)
vmap <C-/> <Plug>(comment_toggle_linewise_visual)
imap <C-/> <C-o><Plug>(comment_toggle_linewise_current)
imap <C-_> <C-o><Plug>(comment_toggle_linewise_current)

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
map s <Plug>Sneak_s
map S <Plug>Sneak_S
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

" vim align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" vim sandwhich
" Additional text objects e.g. viss to select inner text with auto detection
" of surroundings
xmap iss <Plug>(textobj-sandwich-auto-i)
xmap ass <Plug>(textobj-sandwich-auto-a)
omap iss <Plug>(textobj-sandwich-auto-i)
omap ass <Plug>(textobj-sandwich-auto-a)
" For specific chars, e.g. im_
xmap im <Plug>(textobj-sandwich-literal-query-i)
xmap am <Plug>(textobj-sandwich-literal-query-a)
omap im <Plug>(textobj-sandwich-literal-query-i)
omap am <Plug>(textobj-sandwich-literal-query-a)

nnoremap <Leader>hn <cmd>Gitsigns next_hunk<CR>

let g:rooter_patterns = ['.git', 'go.mod']
