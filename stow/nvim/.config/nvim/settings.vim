let mapleader = " "
let g:netrw_banner = 0
syntax sync minlines=3000

"highlight clear
set guifont=FiraCode\ Nerd\ Font\ Mono:h18
set background=dark
try
  "colorscheme PaperColor
  "colorscheme gruvbox
  let g:material_style = "oceanic"
  colorscheme material
  "colorscheme catppuccin
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
endtry

"highlight LineNr ctermbg=none guibg=none
"highlight Normal ctermbg=none guibg=none
"highlight NonText ctermbg=none guibg=none
"highlight SignColumn ctermbg=none guibg=none
"highlight VertSplit ctermbg=none ctermfg=98 cterm=none guibg=none

" Hide tab bar
set showtabline=0

filetype plugin indent on
" CoC TextEdit might fail if hidden is not set.
set hidden

" Some CoC servers have issues with backup files
set nobackup
set nowritebackup

set updatetime=300
set sessionoptions+=winpos,terminal

" Don't pass messages to |ins-completion-menu|
set shortmess+=c
set nowrap
set expandtab
set number
set autoindent
set tabstop=2
set shiftwidth=2

" Enable signcolumn for git projects
set signcolumn=yes
" Set signcolumn for new buffers
autocmd BufRead,BufNewFile * setlocal signcolumn=yes

" Mouse enabled in all modes
set mouse=a

set encoding=UTF-8

set splitbelow
set splitright

set smartcase

" Line size limit
set colorcolumn=100
set cursorline
hi ColorColumn ctermbg=62 guibg=#5f5fd7
hi CursorColumn ctermbg=none ctermfg=211 guibg=none guifg=#fd79a8
hi Cursor ctermbg=211 guibg=#fd79a8
hi IncSearch cterm=none gui=none ctermbg=237 ctermfg=white guibg=#3C474E guifg=#ffffff
hi CursorLine cterm=none gui=none ctermbg=none guibg=none
hi NormalFloat guibg=#2e3e45 ctermbg=239
" Disable spell since the plugin Spelunker will also highlight
set spell
set spelllang=en_us
hi SpellBad gui=undercurl cterm=undercurl ctermbg=none ctermfg=none guibg=none guifg=none

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

command! -nargs=1 SetTab call SetTab(<f-args>)

function! EmptyRegisters()
  let regs=split('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"', '\zs')
  for r in regs
    call setreg(r, [])
  endfor
endfun

command! -nargs=0 EmptyRegisters call EmptyRegisters()

" Trim extra whitespace in whole file
function! Trim()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfun

command! -nargs=0 Trim call Trim()
