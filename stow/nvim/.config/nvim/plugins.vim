call plug#begin('~/.config/nvim/plugged')

" Color schemes
Plug 'NLKNguyen/papercolor-theme'
Plug 'https://github.com/joshdick/onedark.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Icons
Plug 'kyazdani42/nvim-web-devicons'
Plug 'ryanoasis/vim-devicons'

Plug 'kamykn/popup-menu.nvim'

" Enhancements
Plug 'justinmk/vim-sneak'

Plug 'https://github.com/preservim/nerdtree'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
" Telescope media not supported in Mac
" Plug 'nvim-telescope/telescope-media-files.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" Completion/Syntax
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'elixir-editors/vim-elixir'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mattn/emmet-vim'

Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdcommenter'
Plug 'mbbill/undotree'

" Get Multiple cursor like in vscode
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" Git client
Plug 'https://github.com/tpope/vim-fugitive.git'
" Show sign columns for changes in files
Plug 'mhinz/vim-signify'

Plug 'https://github.com/vim-scripts/dbext.vim'

Plug 'https://github.com/lbrayner/vim-rzip'

call plug#end()
