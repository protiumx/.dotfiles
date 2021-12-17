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


