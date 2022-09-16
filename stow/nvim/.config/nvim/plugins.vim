call plug#begin('~/.config/nvim/plugged')

" ==== Color schemes ====
Plug 'NLKNguyen/papercolor-theme'
Plug 'https://github.com/joshdick/onedark.vim'
Plug 'https://github.com/morhetz/gruvbox'
Plug 'marko-cerovac/material.nvim'
Plug 'sainnhe/everforest'

" ==== Icons ====
Plug 'kyazdani42/nvim-web-devicons'

" ==== Enhancements ====
Plug 'feline-nvim/feline.nvim'
Plug 'airblade/vim-rooter'
" Better jump
Plug 'justinmk/vim-sneak'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'junegunn/vim-easy-align'
Plug 'mattn/emmet-vim'
Plug 'arthurxavierx/vim-caser'
" Chang surroundings
Plug 'https://github.com/machakann/vim-sandwich'
Plug 'jiangmiao/auto-pairs'
Plug 'mbbill/undotree'
Plug 'numToStr/Comment.nvim'
Plug 'https://github.com/lbrayner/vim-rzip'
" Multiple cursors
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'nvim-lua/plenary.nvim'
Plug 'kamykn/popup-menu.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'
" Telescope media not supported on Mac
" Plug 'nvim-telescope/telescope-media-files.nvim'

" ==== Completion/Syntax ====
Plug 'https://github.com/vim-scripts/dbext.vim'
"Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'elixir-editors/vim-elixir'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" ==== Git ====
Plug 'https://github.com/tpope/vim-fugitive.git'
" Show sign columns for changes in files
Plug 'lewis6991/gitsigns.nvim'

call plug#end()
