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
  git = {
    subcommands = {
      update         = 'pull --ff-only --progress --rebase=false --force',
      install        = 'clone --depth %i --no-single-branch --progress',
      fetch          = 'fetch --depth 999999 --progress --force',
      checkout       = 'checkout %s --',
      update_branch  = 'merge --ff-only @{u}',
      current_branch = 'branch --show-current',
      diff           = 'log --color=never --pretty=format:FMT --no-show-signature HEAD@{1}...HEAD',
      diff_fmt       = '%%h %%s (%%cr)',
      get_rev        = 'rev-parse --short HEAD',
      get_msg        = 'log --color=never --pretty=format:FMT --no-show-signature HEAD -n 1',
      submodules     = 'submodule update --init --recursive --progress'
    },
    clone_timeout = 60, -- Timeout, in seconds, for git clones
  },
  display = {
    working_sym = 'ﲊ',
    error_sym = '✗ ',
    done_sym = ' ',
    removed_sym = ' ',
    moved_sym = '',
    open_fn = function()
      return require('packer.util').float { border = 'none' }
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

  -- Themes
  use('ellisonleao/gruvbox.nvim')
  use('folke/tokyonight.nvim')

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
    cmd = { 'TSPlaygroundToggle', 'TSNodeUnderCursor' },
  })

  use({
    'rcarriga/nvim-notify',
    config = function()
      require('notify').setup({
        render = 'minimal',
        stages = 'static',
        top_down = false,
        minimum_width = 10,
        timeout = 4000,
        icons = {
          DEBUG = '',
          ERROR = '',
          INFO = '',
          TRACE = '',
          WARN = ''
        },
      })
    end
  })

  use({
    'folke/noice.nvim',
    config = function()
      require('config.noice').setup()
    end,
    requires = {
      -- if you lazy-load any plugin below, make sure to add proper `module='...'` entries
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    }
  })

  use({
    'nvim-lualine/lualine.nvim',
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
        silent_chdir = false,
        update_focused_file = {
          enable = false,
        },
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
    'norcalli/nvim-colorizer.lua',
    cmd = { 'ColorizerToggle', 'ColorizerAttachToBuffer' },
    config = function()
      require('colorizer').setup({
        user_default_options = {
          RGB = false,
          RRGGBB = true,
          names = false,
          RRGGBBAA = false,
          css = false,
          css_fn = true,
          mode = 'background',
        },
      })
    end
  })

  use({
    'junegunn/vim-easy-align',
    cmd = 'EasyAlign',
    config = function()
      -- Start interactive EasyAlign in visual mode (e.g. vipga)
      vim.keymap.set('x', 'gA', '<Plug>(EasyAlign)', { remap = true })
      -- Start interactive EasyAlign for a motion/text object (e.g. gaip)
      vim.keymap.set('n', 'gA', '<Plug>(EasyAlign)', { remap = true })
    end
  })

  use({
    'mattn/emmet-vim',
    setup = function()
      vim.g['user_emmet_leader_key'] = '<C-X>'
    end,
    ft = {
      'handlebars',
      'hbs',
      'html',
      'javascriptreact',
      'jsx',
      'pug',
      'svelte',
      'tsx',
      'typescriptreact',
      'vue',
      'xml',
    },
  })

  use({
    'johmsalas/text-case.nvim',
    after = 'telescope.nvim',
    config = function()
      require('config.text-case').setup()
    end
  })

  -- Change surroundings
  use({
    'machakann/vim-sandwich',
    event = 'BufRead',
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

  use({
    'nvim-tree/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup({
        color_icons = true,
      })
    end
  })

  use {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',

    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
      {
        's1n7ax/nvim-window-picker',
        tag = 'v1.*',
        config = function()
          local picker = require('window-picker')
          picker.setup({
            autoselect_one = true,
            include_current = false,
            filter_rules = {
              -- filter using buffer options
              bo = {
                -- if the file type is one of following, the window will be ignored
                filetype = { 'neo-tree', 'neo-tree-popup', 'notify' },
              },
            },
            other_win_hl_color = '#e35e4f',
          })

          vim.keymap.set('n', '<Leader>W', function()
            local picked_window_id = picker.pick_window() or vim.api.nvim_get_current_win()
            vim.api.nvim_set_current_win(picked_window_id)
          end, { desc = 'Pick a window' })
        end,
      },
    },
    config = function()
      require('config.neotree').setup()
    end
  }

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
      'f3fora/cmp-spell',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      require('config.lsp.cmp').setup()
    end
  })

  -- LSP
  use({
    'ray-x/go.nvim',
    ft = { 'go' },
    config = function()
      require('config.lsp.go').setup()
    end,
    requires = {
      'ray-x/guihua.lua',
    },
  })

  use({
    'neovim/nvim-lspconfig',
    ft = {
      'asm',
      'c',
      'cpp',
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

      -- Snippets
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',

      -- Show lsp progress
      {
        'j-hui/fidget.nvim',
        tag = 'legacy',
      },

      -- Better UI for LSP commands
      {
        'glepnir/lspsaga.nvim',
        branch = 'main',
      },

      {
        'b0o/schemastore.nvim',
      },
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
