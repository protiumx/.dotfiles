vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use('wbthomason/packer.nvim')

  -- Telescope
  use({
	  'nvim-telescope/telescope.nvim', branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  })
  use({'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })
  use('nvim-telescope/telescope-file-browser.nvim')

  -- Themes
  use('NLKNguyen/papercolor-theme')

  -- Icons
  use('kyazdani42/nvim-web-devicons')

  -- Treesitter
  use({'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'})
  use('nvim-treesitter/playground')
  
  -- Enhancement
  use('feline-nvim/feline.nvim')
  use('airblade/vim-rooter')
  -- Better jump
  use('justinmk/vim-sneak')
  use({
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end
  })
  use('junegunn/vim-easy-align')
  use('mattn/emmet-vim')
  use('arthurxavierx/vim-caser')
  -- Change surroundings
  use('machakann/vim-sandwich')
  use('jiangmiao/auto-pairs')
  use('mbbill/undotree')
  use('lbrayner/vim-rzip')
  use({
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup({ ignore = '^$' })
    end
  })
  use('lukas-reineke/indent-blankline.nvim')

  -- Multiple cursors
  use({'mg979/vim-visual-multi', branch = 'master'})

  -- Git
  use('tpope/vim-fugitive')
  -- Show sign columns for changes in files
  use('lewis6991/gitsigns.nvim')

  -- LSP
  use({
	  'VonHeikemen/lsp-zero.nvim',
	  requires = {
		  -- LSP Support
		  {'neovim/nvim-lspconfig'},
		  {'williamboman/mason.nvim'},
		  {'williamboman/mason-lspconfig.nvim'},

		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},
		  {'hrsh7th/cmp-buffer'},
		  {'hrsh7th/cmp-path'},
		  {'saadparwaiz1/cmp_luasnip'},
		  {'hrsh7th/cmp-nvim-lsp'},
		  {'hrsh7th/cmp-nvim-lua'},

		  -- Snippets
		  {'L3MON4D3/LuaSnip'},
		  {'rafamadriz/friendly-snippets'},
	  }
  })
end)
