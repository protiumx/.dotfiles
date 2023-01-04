-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer_bootstrap = false

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
local status_ok, _ = pcall(require, 'packer')
if not status_ok then
  return
end

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use('wbthomason/packer.nvim')

  -- Telescope
  use({
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('config.telescope').setup()
    end
  })

  use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })

  use('nvim-telescope/telescope-file-browser.nvim')

  -- Themes
  use('NLKNguyen/papercolor-theme')

  -- Icons
  use('kyazdani42/nvim-web-devicons')

  -- Treesitter
  use({
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('config.treesitter').setup()
    end
  })

  use({
    'nvim-treesitter/playground',
    cmd = 'TSPlay',
  })

  -- Enhancement
  use({
    'feline-nvim/feline.nvim', -- Status line
    config = function()
      require('config.feline').setup()
    end
  })

  use({
    'ahmedkhalf/project.nvim',
    config = function()
      require('project_nvim').setup({
        detection_methods = { 'pattern' },
        show_hidden = true,
        patterns = {
          'go.mod',
          'Makefile',
          'package.json',
          '.git',
          '!.git/worktrees',
        },
      })
    end
  })

  use {
    'AckslD/nvim-neoclip.lua',
    requires = { 'nvim-telescope/telescope.nvim' },
    config = function()
      require('config.neoclip').setup()
    end
  }

  -- Better jump
  use({
    'justinmk/vim-sneak',
    event = "BufRead",
    config = function()
      require('config.vim-sneak').setup()
    end
  })

  use({
    'norcalli/nvim-colorizer.lua', -- colorize hexa and rgb strings
    cmd = 'Colorizer',
    config = function()
      require('colorizer').setup({
        user_default_options = {
          RGB = true,
          RRGGBB = true,
          names = false,
          RRGGBBAA = false,
          css = false,
          css_fn = true,
          mode = 'foreground',
        },
      })
    end
  })

  use({
    'junegunn/vim-easy-align',
    cmd = 'EasyAlignEnable',
    config = function()
      -- Start interactive EasyAlign in visual mode (e.g. vipga)
      vim.keymap.set('x', 'ga', '<Plug>(EasyAlign)', { remap = true })
      -- Start interactive EasyAlign for a motion/text object (e.g. gaip)
      vim.keymap.set('n', 'ga', '<Plug>(EasyAlign)', { remap = true })
    end
  })

  use({
    'mattn/emmet-vim',
    config = function()
      vim.g['user_emmet_leader_key'] = '<C-X>'
    end,
    ft = {
      'django-html',
      'ejs',
      'glimmer',
      'handlebars',
      'hbs',
      'html',
      'htmldjango',
      'javascriptreact',
      'jsx',
      'markdown',
      'php',
      'pug',
      'rescript',
      'svelte',
      'tsx',
      'typescriptreact',
      'vue',
      'xml',
    },
  })

  use({
    'arthurxavierx/vim-caser',
    cmd = 'VimCaserEnable'
  })

  -- Change surroundings
  use({
    'machakann/vim-sandwich',
    event = "BufRead",
    setup = function()
      vim.g['sandwich_no_default_key_mappings'] = 1
    end,
    config = function()
      require('config.vim-sandwich').setup()
    end,
  })

  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup({})
    end
  }

  use({
    'lbrayner/vim-rzip',
    cmd = 'VimZip',
  })

  use({
    'numToStr/Comment.nvim',
    event = "BufRead",
    config = function()
      require('config.comment').setup()
    end
  })

  -- Multiple cursors
  use({
    'mg979/vim-visual-multi',
    branch = 'master',
    event = "BufRead",
  })

  -- Git
  use({
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set('n', '<F3>', function()
        local name = vim.fn.bufname('fugitive:///*/.git//')
        if name ~= '' and vim.fn.buflisted(name) ~= 0 then
          vim.cmd [[ execute ":bd" bufname('fugitive:///*/.git//') ]]
        else
          vim.cmd [[vertical Git | vertical resize 40 | setlocal noequalalways wrap readonly nomodifiable noswapfile]]
        end
      end)

      vim.keymap.set('n', '<Leader>G', ':G | only<CR>', { silent = true })
    end
  })

  -- Show sign columns for changes in files
  use({
    'lewis6991/gitsigns.nvim',
    after = 'project.nvim',
    cond = function()
      -- project.nvim should have setup the path when this is executed
      return vim.fn.isdirectory(vim.fn.getcwd() .. '/.git/')
    end,
    event = "BufRead",
    config = function()
      require('config.gitsigns').setup()
    end
  })

  -- LSP
  use({
    'neovim/nvim-lspconfig',
    ft = {
      'go',
      'lua',
      'rust',
    },
    requires = {
      -- LSP Support
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Autocompletion
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',

      -- Snippets
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',

      -- Show lsp progress
      'j-hui/fidget.nvim',
      {
        'glepnir/lspsaga.nvim', -- better ui
        branch = 'main',
      }
    },
    config = function()
      require('config.lsp').setup()
    end
  })

  -- Debugging
  use {
    'mfussenegger/nvim-dap',
    opt = true,
    event = 'BufReadPre',
    cmd = 'Dap',
    module = { 'dap' },
    wants = {
      'nvim-dap-virtual-text',
      'nvim-dap-ui',
    },
    requires = {
      'theHamsta/nvim-dap-virtual-text',
      'rcarriga/nvim-dap-ui',
      { 'leoluz/nvim-dap-go', module = 'dap-go' },
    },
    config = function()
      require('config.dap').setup()
    end,
  }

  -- Sync plugins after installing packer
  if packer_bootstrap then
    require('packer').sync()
  end
end)
