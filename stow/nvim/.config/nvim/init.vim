" =============================================================================
" plugins
" =============================================================================

call plug#begin('~/.config/nvim/plugged')

Plug 'drewtempelmeyer/palenight.vim'
Plug 'https://github.com/rafi/awesome-vim-colorschemes'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Icons {
Plug 'kyazdani42/nvim-web-devicons'
Plug 'ryanoasis/vim-devicons'
" }

" Spelling
Plug 'kamykn/spelunker.vim'

Plug 'kamykn/popup-menu.nvim'
" Enhancements
Plug 'justinmk/vim-sneak'
" GUI {
Plug 'https://github.com/preservim/nerdtree'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
" }

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'tpope/vim-surround'
Plug 'preservim/nerdcommenter'
Plug 'mbbill/undotree'

" Get Multiple cursor like in vscode
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'jiangmiao/auto-pairs'

" Git client
Plug 'https://github.com/tpope/vim-fugitive.git'

" Show sign columns for changes in files
Plug 'mhinz/vim-signify'

" Better ctags {
Plug 'preservim/tagbar'
Plug 'universal-ctags/ctags'
" }

call plug#end()

" =============================================================================
" Base settings and mappings
" =============================================================================

colorscheme PaperColor
"colorscheme palenight

let mapleader = "\<space>"

set expandtab
set number
set autoindent
set tabstop=2
set shiftwidth=2
" always show signs column
set scl=yes
" mouse enabled in all modes
set mouse=a
set encoding=UTF-8
set background=dark
set splitbelow
set splitright

" Searching {
set smartcase
set ignorecase
" }

" Line size {
set colorcolumn=100
highlight ColorColumn ctermbg=0 guibg=lightgrey
" set signcolumn for new buffers
autocmd BufRead,BufNewFile * setlocal signcolumn=yes
" }

set nospell
set spelllang=en_us
set noshowmode
" do not show the file name
set shortmess+=F

" don’t reset cursor to start of line when moving around.
set nostartofline

" wildignore {
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
" } wildignore

" delete to blackhole register
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" remap C-c to esc in insert mode
inoremap <C-c> <esc>
nnoremap ; :

" quick-save
nmap <leader>w :w<CR>

" replaces the word under the cursor downwards. press . to repeat
nnoremap <Leader>c* *``cgn
" upwards
nnoremap <Leader>c# *``cgn
" delete word
nnoremap <Leader>d* *``cgn
" close buffer without changing window layout
nnoremap :: :bp\|bd #<CR>
" copy from cursor to end of line
nnoremap Y y$
"jump next/prev but centered
nnoremap n nzzzv
nnoremap N Nzzzv

" Moving lines up or down preserving format {
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
inoremap <C-j> <esc>:m .+1<CR>==gi
inoremap <C-k> <esc>:m .-2<CR>==gi
nnoremap <leader>j :m .+1<CR>==
nnoremap <leader>k :m .-2<CR>==
" }

" new buffer vertical split
nnoremap <leader>vs :vnew<cr>
" select everithing
nnoremap <C-A> ggVG
" open new file adjacent to current file
nnoremap <leader>o :e <C-R>=expand("%:p:h") . "/" <CR>
" toggle between buffers current and prev buffer
nnoremap <leader><leader> <c-^>

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

" custom function to fold blocks
function! CFoldText()
    let line = getline(v:foldstart)
    let folded_line_num = v:foldend - v:foldstart
    let line_text = substitute(line, '^"{\+', '', 'g')
    let fillcharcount = &textwidth - len(line_text) - len(folded_line_num)
    return '+'. repeat('-', 4) . line_text . repeat('.', fillcharcount) . ' (' . folded_line_num . ' L)'
endfunction

set foldtext=CFoldText()
set foldmethod=expr

if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

nnoremap <F9> :UndotreeToggle<CR>

augroup compileandrun
    autocmd!
		autocmd filetype rust nmap <f5> :w <bar> :!cargo run <cr>
    autocmd filetype rust nmap <f6> :w <bar> :!cargo build <cr>
    autocmd filetype python nmap <f5> :w <bar> :!python % <cr>
		autocmd FileType go nmap <f5> <Plug>(go-run)
augroup END

" [preservim/tagbar] map F8 to CTagbar
nmap <F8> :TagbarToggle<CR>

" [tommcdo/vim-lion]
let b:lion_squeeze_spaces = 1

" NERDCommenter {
nmap <C-_> <Plug>NERDCommenterToggle
vmap <C-_> <Plug>NERDCommenterToggle<CR>gv
" }

" Spelling {
let g:spelunker_max_suggest_words = 5
" override highlight setting.
highlight SpelunkerSpellBad cterm=underline ctermfg=135 guisp=169 gui=None guifg=#af5fff
highlight SpelunkerComplexOrCompoundWord cterm=underline ctermfg=135 guisp=169 gui=None guifg=#af5fff
let g:spelunker_white_list_for_user = ['grpc', 'uuid']
" Disable URI checking. (default: 0)
let g:spelunker_disable_uri_checking = 1
" }

" Go syntax highlighting {
let g:go_highlight_fields = 1
let g:go_highlight_functions = 0
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
" }

" CoC {
filetype plugin indent on
" textEdit might fail if hidden is not set.
set hidden
" some servers have issues with backup files, see #649.
set nobackup
set nowritebackup
set updatetime=300
" don't pass messages to |ins-completion-menu|
set shortmess+=c

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

hi CocUnderline gui=undercurl term=undercurl
hi CocErrorHighlight ctermfg=red  guifg=#c4384b gui=undercurl term=undercurl
hi CocWarningHighlight ctermfg=yellow guifg=#c4ab39 gui=undercurl term=undercurl

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <silent> gh :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" Remap for rename current word
nmap <F2> <Plug>(coc-rename)
" Formatting selected code.
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)
" use `:OR` for organize import of current buffer
command! -nargs=0 ORG :call CocAction('runCommand', 'editor.action.organizeImport')

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>

" Telescope {
nnoremap <leader>ff <cmd>Telescope find_files<cr>
" open in current file pwd
nnoremap <leader>fc :lua require('telescope.builtin').file_browser({cwd = vim.fn.expand('%:p:h')})
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fr :lua require('telescope.builtin').registers()<CR>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
" display help tags for all extensions
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fk :lua require('telescope.builtin').keymaps()<CR>
nnoremap <leader>fz :lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>
" }

" NerdTree {
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1
nnoremap <leader>nf :NERDTreeFocus<CR>
nnoremap <leader>nt :NERDTreeToggle %<CR>

" Check if NERDTree is open or active
function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" sync open file with NERDTree
" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

" Highlight currently open buffer in NERDTree
" autocmd BufEnter * call SyncTree()
let g:NERDTreeIgnore = ['^node_modules$', '^target$', '.git$', 'build$']
" }

" Airline {
let g:airline_theme='papercolor'
" show git branch
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#hunks#enabled=0
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
" }

" Fugitive {
function! ToggleGStatus()
    if buflisted(bufname('.git/index'))
        bd .git/index
    else
			vertical Git | vertical resize 40
    endif
endfunction
command ToggleGStatus :call ToggleGStatus()
nmap <F3> :ToggleGStatus<CR>
nmap <leader>gj :diffget //3<CR>
nmap <leader>gf :diffget //2<CR>
" }
