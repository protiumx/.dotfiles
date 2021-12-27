let mapleader = "\<space>"

colorscheme PaperColor

filetype plugin indent on
" CoC TextEdit might fail if hidden is not set.
set hidden

" Some CoC servers have issues with backup files, see #649.
set nobackup
set nowritebackup

set updatetime=300
set sessionoptions+=winpos,terminal

" Don't pass messages to |ins-completion-menu|
set shortmess+=c

set expandtab
set number
set autoindent
set tabstop=2
set shiftwidth=2

" Always show signs column
set scl=yes

" Mouse enabled in all modes
set mouse=a

set encoding=UTF-8

set splitbelow
set splitright

set smartcase

" Line size
set colorcolumn=100
highlight ColorColumn ctermbg=0
highlight CursorColumn ctermbg=none ctermfg=magenta

" Set signcolumn for new buffers
autocmd BufRead,BufNewFile * setlocal signcolumn=yes


" Disable spell since the plugin Spelunker will also highlight
"set nospell
set spell
set spelllang=en_us

set noshowmode
" Do not show the file name. Airline already does it
set shortmess+=F

" Don’t reset cursor to start of line when moving around.
set nostartofline

" Wild ignore
set wildignore=*.o,*.obj,*~,*.exe,*.a,*.pdb,*.lib
set wildignore+=*.so,*.pyc,*.pyo,*.bin,*.dex
set wildignore+=*.log,*.pyc,*.sqlite,*.sqlite3,*.min.js,*.min.css,*.tags
set wildignore+=*.zip,*.7z,*.rar,*.gz,*.tar,*.gzip,*.bz2,*.tgz,*.xz
set wildignore+=*.png,*.jpg,*.gif,*.bmp,*.tga,*.pcx,*.ppm,*.img,*.iso
set wildignore+=*.pdf,*.dmg,*.app,*.ipa,*.apk,*.mobi,*.epub
set wildignore+=*.mp4,*.avi,*.flv,*.mov,*.mkv,*.swf,*.swc
set wildignore+=*.ppt,*.pptx,*.doc,*.docx,*.xlt,*.xls,*.xlsx,*.odt,*.wps
set wildignore+=*/.git/*,*.DS_Store
set wildignore+=*/node_modules/*,*/build/*,*/logs/*,*/dist/*,*/tmp/*

" Function to set tab width to n spaces
function! SetTab(n)
  let &l:tabstop=a:n
  let &l:softtabstop=a:n
  let &l:shiftwidth=a:n
  set expandtab
endfunction

fun! EmptyRegisters()
  let regs=split('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"', '\zs')
  for r in regs
    call setreg(r, [])
  endfor
endfun

command! -nargs=1 SetTab call SetTab(<f-args>)

" Function to trim extra whitespace in whole file
function! Trim()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfun

command! -nargs=0 Trim call Trim()

" Custom function to fold blocks
function! CFoldText()
    let line = getline(v:foldstart)
    let folded_line_num = v:foldend - v:foldstart
    let line_text = substitute(line, '^"{\+', '', 'g')
    let fillcharcount = &textwidth - len(line_text) - len(folded_line_num)
    return '+'. repeat('-', 4) . line_text . repeat('.', fillcharcount) . ' (' . folded_line_num . ' L)'
endfunction

set foldtext=CFoldText()
set foldmethod=expr

" ====== Plugins settings ======

lua << EOF
local opts = {
  auto_session_enabled = true,
  }

require('auto-session').setup(opts)
require('telescope').load_extension('media_files')
require("project_nvim").setup {
  patterns = { ".git", "package.json" },
  show_hidden = true,
  }
require('telescope').load_extension('projects')
EOF

let g:floaterm_keymap_toggle = '<F12>'

nnoremap <F9> :UndotreeToggle<CR>

" [preservim/tagbar] map F8 to CTagbar
nmap <F8> :TagbarToggle<CR>

" [tommcdo/vim-lion]
let b:lion_squeeze_spaces = 1

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

let g:PaperColor_Theme_Options = {
      \   'theme': {
      \     'default.dark': {
      \       'override' : {
      \         'color00' : ['#080808', '232'],
      \         'linenumber_bg' : ['#080808', '232']
      \       }
      \     }
      \   }
      \ }
set background=dark
