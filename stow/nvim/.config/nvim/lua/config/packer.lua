-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  })
  vim.o.runtimepath = vim.fn.stdpath('data') .. '/site/pack/*/start/*,' .. vim.o.runtimepath
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use('wbthomason/packer.nvim')

  -- Telescope
  use({
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    requires = { { 'nvim-lua/plenary.nvim' } }
  })
  use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })
  use('nvim-telescope/telescope-file-browser.nvim')

  -- Themes
  use('NLKNguyen/papercolor-theme')

  -- Icons
  use('kyazdani42/nvim-web-devicons')

  -- Treesitter
  use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
  use('nvim-treesitter/playground')

  -- Enhancement
  use('feline-nvim/feline.nvim') -- status line
  use('airblade/vim-rooter') -- set cwd if .git folder is found
  -- Better jump
  use('justinmk/vim-sneak') -- sneaky jumps
  use({
    'norcalli/nvim-colorizer.lua', -- colorize hexa color strings
    config = function()
      require('colorizer').setup()
    end
  })
  use('junegunn/vim-easy-align')
  use('mattn/emmet-vim')
  use('arthurxavierx/vim-caser')
  -- Change surroundings
  use('machakann/vim-sandwich') -- surroundings
  use {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
    end
  }
  use('mbbill/undotree')
  use('lbrayner/vim-rzip')
  use({
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup({ ignore = '^$' })
    end
  })

  -- Multiple cursors
  use({ 'mg979/vim-visual-multi', branch = 'master' })

  -- Git
  use('tpope/vim-fugitive')
  -- Show sign columns for changes in files
  use('lewis6991/gitsigns.nvim')

  -- LSP
  use({
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },

      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
    }
  })

  use({
    "glepnir/lspsaga.nvim",
    branch = "main",
  })

  -- Sync plugins after installing packer
  if packer_bootstrap then
    require('packer').sync()
  end
end)
