let mapleader = "\<space>"

colorscheme PaperColor
set background=dark

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

" Remove white spaces before saving
autocmd BufWritePre * :%s/\s\+$//e

augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=500}
augroup END

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

