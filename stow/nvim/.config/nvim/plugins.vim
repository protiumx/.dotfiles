call plug#begin('~/.config/nvim/plugged')

" Color schemes
Plug 'drewtempelmeyer/palenight.vim'
Plug 'https://github.com/rafi/awesome-vim-colorschemes'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" }

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
