---@diagnostic disable: different-requires
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

local packer = require('packer')

packer.reset()
packer.init({
  auto_clean = true,
  compile_on_sync = true,
  git = { clone_timeout = 6000 },
  display = {
    working_sym = "ﲊ",
    error_sym = "✗ ",
    done_sym = " ",
    removed_sym = " ",
    moved_sym = "",
    open_fn = function()
      return require("packer.util").float { border = "none" }
    end,
  },
})

return packer.startup(function(use)
  -- Packer can manage itself
  use('wbthomason/packer.nvim')

  -- Telescope
  use({
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    config = function()
      require('config.telescope').setup()
    end,
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-live-grep-args.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    }
  })

  use({
    'nvim-tree/nvim-tree.lua',
    config = function()
      require('config.nvim-tree').setup()
    end,
    requires = {
      'nvim-tree/nvim-web-devicons',
    }
  })

  -- Themes
  use('NLKNguyen/papercolor-theme')
  use('ellisonleao/gruvbox.nvim')

  -- Treesitter
  use({
    'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
    event = 'BufRead',
    config = function()
      require('config.treesitter').setup()
    end
  })

  use({
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  })

  use({
    'nvim-treesitter/playground',
    cmd = 'TSPlaygroundToggle',
  })

  use({
    "folke/noice.nvim",
    config = function()
      require('config.noice').setup()
    end,
    requires = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    }
  })

  use {
    "echasnovski/mini.nvim",
    config = function()
      local duck = [[
⡏⠙⠻⢦⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⠶⠟⠛⠿⠗⣦⣄⠀⠀⠀⠀
⡇⠀⠀⠀⠀⠙⠦⣄⠀⠀⠀⠀⠀⠀⠀⢀⣴⠋⠀⠀⠀⠀⠀⠀⠀⠉⢧⡀⠀⠀
⠙⢄⠀⠀⠀⠀⠀⠙⠲⢦⣀⠀⠀⠀⠀⣸⠋⠀⠀⠀⢠⣤⠀⠀⠀⠀⠘⢳⡀⠀
⠀⠈⠳⣀⠀⠀⠀⠀⠀⠀⠉⠻⢦⣤⣼⠴⠖⠒⣄⠀⠈⠉⠀⠀⠀⠀⠀⠈⣵⠀
⠀⠀⠀⠈⠳⣄⠀⠀⠀⠀⠀⠀⢀⣿⠋⠀⠀⠀⠈⢆⠀⠀⠀⠀⠀⠀⠀⠀⠀⢣
⠀⠀⠀⠀⠀⠈⠳⢦⡀⠀⠀⠀⣸⠁⠀⠀⠀⠀⣠⣼⣷⡤⢤⣄⠀⠀⠀⠀⠀⣻
⠀⠀⠀⠀⠀⠀⠀⠀⠙⢦⣤⣴⠋⠀⠀⠀⢀⣴⣿⣿⢿⠁⢘⣻⠀⠀⠀⠀⠀⣿
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠻⣔⣢⣲⣼⡿⣿⣿⠟⠁⠀⢸⠾⠀⠀⠀⠀⠀⢸
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠫⣿⠋⠀⠀⠀⣾⡇⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠇⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⡏⠀⠀⠀⠀⠀⠀⠀
]]

      local capy = [[
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⣬⠷⣶⡖⠲⡄⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⣠⠶⠋⠁⠀⠸⣿⡀⠀⡁⠈⠙⠢⠤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⢠⠞⠁⠀⠀⠀⠀⠀⠉⠣⠬⢧⠀⠀⠀⠀⠈⠻⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⢀⡴⠃⠀⠀⢠⣴⣿⡿⠀⠀⠀⠐⠋⠀⠀⠀⠀⠀⠀⠘⠿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⢀⡴⠋⠀⠀⠀⠀⠈⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠒⠒⠓⠛⠓⠶⠶⢄⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⢠⠎⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠦⣀⠀⠀⠀⠀⠀⠀⠀⠀
⡞⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⢷⡄⠀⠀⠀⠀⠀⠀
⢻⣇⣹⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢦⡀⠀⠀⠀⠀
⠀⠻⣟⠋⠀⠀⠀⠀⠀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠻⣄⠀⠀⠀
⠀⠀⠀⠉⠓⠒⠊⠉⠉⢸⡙⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⠀⠀⠘⣆⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣱⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣿⠀⠀⠀⠀⠀⢻⡄⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠟⣧⡀⠀⠀⢀⡄⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡿⠇⠀⠀⠀⠀⠀⠀⢣⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⡧⢿⡀⠚⠿⢻⡆⠀⠀⠀⠀⠀⢠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⡇⠀⠀⠀⠀⠀⠀⠀⠘⡆
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⠀⠀⠈⢹⡀⠀⠀⠀⠀⣾⡆⠀⠀⠀⠀⠀⠀⠀⠀⠾⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠨⢷⣾⠀⠸⡷⠀⠀⠀⠘⡿⠂⠀⠀⠀⢀⡴⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡇
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡄⠳⢼⣧⡀⠀⠀⢶⡼⠦⠀⠀⠀⡞⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠃
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⡎⣽⠿⣦⣽⣷⠿⠒⠀⠀⠀⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⠁⣴⠃⡿⠀⠀⢠⠆⠢⡀⠀⠀⠀⠈⢧⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠇⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣠⣠⠏⠀⣸⢰⡇⠀⢠⠏⠀⠀⠘⢦⣀⣀⠀⢀⠙⢧⡀⠀⠀⠀⠀⠀⠀⠀⠀⡰⠁⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠾⠿⢯⣤⣆⣤⣯⠼⠀⠀⢸⠀⠀⠀⠀⠀⣉⠭⠿⠛⠛⠚⠟⡇⠀⠀⣀⠀⢀⡤⠊⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠀⢸⣷⣶⣤⣦⡼⠀⠀⠀⣴⣯⠇⡀⣀⣀⠤⠤⠖⠁⠐⠚⠛⠉⠁⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣛⠁⢋⡀⠀⠀⠀⠀⣛⣛⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
      ]]
      local starter = require "mini.starter"
      starter.setup {
        items         = { { name = '', action = '', section = '' } },
        header        = duck,
        footer        = '',
        silent        = true,
        content_hooks = {
          starter.gen_hook.aligning("center", "top"),
        },
      }
    end,
  }

  use({
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require('config.lualine').setup()
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

  use({
    'numToStr/FTerm.nvim',
    config = function()
      require('config.term').setup()
    end
  })

  use({
    'sindrets/winshift.nvim',
    cmd = 'WinShift',
    config = function()
      vim.keymap.set('n', '<C-w>m', '<Cmd>WinShift<CR>')
      vim.keymap.set('n', '<C-w>x', '<Cmd>WinShift swap<CR>')
    end
  })

  use({
    'AckslD/nvim-neoclip.lua',
    requires = { 'nvim-telescope/telescope.nvim' },
    config = function()
      require('config.neoclip').setup()
    end
  })

  -- Better jump
  use({
    'justinmk/vim-sneak',
    event = 'BufRead',
    config = function()
      require('config.vim-sneak').setup()
    end
  })

  use({
    'norcalli/nvim-colorizer.lua', -- colorize hexa and rgb strings
    cmd = { 'ColorizerToggle', 'ColorizerAttachToBuffer' },
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
    cmd = 'EasyAlign',
    config = function()
      -- Start interactive EasyAlign in visual mode (e.g. vipga)
      vim.keymap.set('x', 'ga', '<Plug>(EasyAlign)', { remap = true })
      -- Start interactive EasyAlign for a motion/text object (e.g. gaip)
      vim.keymap.set('n', 'ga', '<Plug>(EasyAlign)', { remap = true })
    end
  })

  use({
    'mattn/emmet-vim',
    setup = function()
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
      'php',
      'pug',
      'rescript',
      'svelte',
      'tsx',
      'typescriptreact',
      'vue',
      'xml',
      'zsh',
    },
  })

  use { "johmsalas/text-case.nvim",
    config = function()
      require('config.text-case').setup()
    end
  }

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
      require('config.autopairs').setup()
    end
  }

  use({
    'numToStr/Comment.nvim',
    event = 'BufRead',
    config = function()
      require('config.comment').setup()
    end
  })

  -- Multiple cursors
  use({
    'mg979/vim-visual-multi',
    branch = 'master',
    event = 'BufRead',
  })

  -- Show sign columns for changes in files
  use({
    'lewis6991/gitsigns.nvim',
    cond = function()
      return vim.fn.isdirectory(vim.fn.getcwd() .. '/.git/')
    end,
    config = function()
      require('config.gitsigns').setup()
    end
  })

  use({
    'sindrets/diffview.nvim',
    cond = function()
      return vim.fn.isdirectory(vim.fn.getcwd() .. '/.git/')
    end,
    config = function()
      require('config.diffview').setup()
    end,
    requires = 'nvim-lua/plenary.nvim',
  })

  -- Autocompletion
  use({
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'f3fora/cmp-spell',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      require('config.lsp.cmp').setup()
    end
  })

  -- LSP
  use({
    'neovim/nvim-lspconfig',
    ft = {
      'asm',
      'c',
      'go',
      'lua',
      'json',
      'python',
      'rust',
      'bash',
      'dockerfile',
      'terraform',
      'yaml',
    },
    requires = {
      -- LSP Support
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      'ray-x/go.nvim',
      'ray-x/guihua.lua',

      -- Snippets
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',

      -- Show lsp progress
      'j-hui/fidget.nvim',

      -- Better UI for LSP commands
      {
        'glepnir/lspsaga.nvim',
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
    ft = {
      'go',
    },
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
