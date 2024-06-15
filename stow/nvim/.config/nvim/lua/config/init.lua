-- require('config.packer')
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  {
    'ellisonleao/gruvbox.nvim',
    lazy = false,
    priority = 1000,
  },

  {
    'MunifTanjim/nui.nvim',
    lazy = false,
    priority = 1000,
  },

  {

    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'rcarriga/nvim-notify',
    },
    config = function()
      require('config.noice').config()
    end,
  },

  {
    'nvim-telescope/telescope.nvim',
    version = '0.1.x',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-live-grep-args.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
      },
    },
    config = function()
      require('config.telescope').config()
    end,
  },

  {
    'smoka7/hop.nvim',
    config = function()
      require('config.hop').config()
    end,
  },

  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('config.lualine').config()
    end,
  },

  {

    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = function()
      pcall(require('nvim-treesitter.install').update({ with_sync = true }))
    end,
    config = function()
      require('config.treesitter').config()
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },

  {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter' },
    opts = {
      use_default_keymaps = false,
      check_syntax_error = true,
      max_join_length = 10,
      -- hold|start|end:
      -- hold - cursor follows the node/place on which it was called
      -- start - cursor jumps to the first symbol of the node being formatted
      -- end - cursor jumps to the last symbol of the node being formatted
      cursor_behavior = 'hold',
      -- Notify about possible problems or not
      notify = true,
      -- Use `dot` for repeat action
      dot_repeat = true,
    },
    keys = {
      {
        '<Leader>ts',
        function()
          require('treesj').split()
        end,
        desc = 'TS Split lines',
        silent = true,
      },
      {
        '<Leader>tj',
        function()
          require('treesj').join()
        end,
        desc = 'TS Join lines',
        silent = true,
      },
    },
  },

  {
    'rcarriga/nvim-notify',
    opts = {
      render = 'minimal',
      stages = 'static',
      top_down = false,
      minimum_width = 10,
      timeout = 5000,
      icons = {
        DEBUG = '',
        ERROR = '',
        INFO = '',
        TRACE = '',
        WARN = '',
      },
    },
  },

  {
    'ahmedkhalf/project.nvim',
    config = function() end,
    opts = {
      manual_mode = true,
      detection_methods = { 'pattern' },
      show_hidden = true,
      silent_chdir = false,
      update_focused_file = {
        enable = false,
      },
      patterns = {
        'go.mod',
        'Cargo.toml',
        'package.json',
        '.git',
        '!.git/worktrees',
      },
    },
  },

  {
    'sindrets/winshift.nvim',
    cmd = 'WinShift',
    keys = {
      { '<C-w>m', '<Cmd>WinShift<CR>' },
      { "<C-w>'", '<Cmd>WinShift swap<CR>' },
    },
  },

  {

    'AckslD/nvim-neoclip.lua',
    dependencies = { 'nvim-telescope/telescope.nvim' },
  },

  {
    'norcalli/nvim-colorizer.lua',
    cmd = { 'ColorizerToggle', 'ColorizerAttachToBuffer' },
    opts = {
      user_default_options = {
        RGB = false,
        RRGGBB = true,
        names = false,
        RRGGBBAA = false,
        css = false,
        css_fn = true,
        mode = 'background',
      },
    },
  },

  {
    'junegunn/vim-easy-align',
    cmd = 'EasyAlign',
    keys = {
      -- Start interactive EasyAlign in visual mode (e.g. vipga)
      { 'gA', '<Plug>(EasyAlign)', mode = 'x', remap = true },
      -- Start interactive EasyAlign for a motion/text object (e.g. gaip)
      { 'gA', '<Plug>(EasyAlign)', remap = true },
    },
  },

  {
    'johmsalas/text-case.nvim',
    dependencies = { 'telescope.nvim' },
  },

  {
    'machakann/vim-sandwich',
    event = 'BufRead',
    init = function()
      vim.g['sandwich_no_default_key_mappings'] = 1
    end,
  },

  {
    'nvim-tree/nvim-web-devicons',
    opts = {
      color_icons = true,
    },
  },

  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    cmd = 'Neotree',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
      {
        's1n7ax/nvim-window-picker',
        name = 'window-picker',
        event = 'VeryLazy',
        version = '2.*',
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
            highlights = {
              statusline = {
                focused = {
                  bg = '#e35e4f',
                  bold = true,
                },
                unfocused = {
                  bg = '#e35e4f',
                  bold = true,
                },
              },
            },
          })

          vim.keymap.set('n', '<C-w>S', function()
            local picked_window_id = picker.pick_window() or vim.api.nvim_get_current_win()
            vim.api.nvim_set_current_win(picked_window_id)
          end, { desc = 'Pick a window' })
        end,
      },
    },
    config = function()
      require('config.neotree').config()
    end,
  },

  {

    'lewis6991/gitsigns.nvim',
    cond = function()
      return vim.fn.isdirectory(vim.fn.getcwd() .. '/.git/')
    end,
    config = function()
      require('config.gitsigns').config()
    end,
  },

  {

    'sindrets/diffview.nvim',
    cond = function()
      return vim.fn.isdirectory(vim.fn.getcwd() .. '/.git/')
    end,
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('config.diffview').config()
    end,
  },

  {

    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
    },
    config = function()
      require('config.neogit').config()
    end,
  },

  {

    'L3MON4D3/LuaSnip',
    event = 'InsertEnter',
    dependencies = {
      'rafamadriz/friendly-snippets',
    },
    config = function()
      require('config.luasnip').config()
    end,
  },

  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'f3fora/cmp-spell',
      'saadparwaiz1/cmp_luasnip',
      'L3MON4D3/LuaSnip',
    },
    config = function()
      require('config.cmp').config()
    end,
  },

  {
    'ray-x/go.nvim',
    ft = { 'go' },
    dependencies = {
      'ray-x/guihua.lua',
    },
    config = function()
      require('config.lsp.go').config()
    end,
  },

  {

    'mfussenegger/nvim-dap',
    cmd = 'DapContinue',
    dependencies = {
      'theHamsta/nvim-dap-virtual-text',
      'nvim-neotest/nvim-nio',
      'rcarriga/nvim-dap-ui',
    },
    config = function()
      require('config.dap')
    end,
  },

  {

    'stevearc/conform.nvim',
    config = function()
      require('config.conform').config()
    end,
  },

  {

    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/neotest-go',
      'rouge8/neotest-rust',
    },
    ft = {
      'go',
      'rust',
    },
    config = function()
      require('config.lsp.neotest').config()
    end,
  },

  {
    event = 'VeryLazy',
    'folke/trouble.nvim',
  },

  {
    'neovim/nvim-lspconfig',
    ft = {
      'asm',
      'bash',
      'c',
      'cpp',
      'dockerfile',
      'html',
      'go',
      'javascript',
      'json',
      'lua',
      'ocaml',
      'python',
      'rust',
      'sh',
      'sql',
      'terraform',
      'typescript',
      'svelte',
      'yaml',
      'zsh',
    },
    dependencies = {
      -- LSP Support
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Show lsp progress
      {
        'j-hui/fidget.nvim',
      },

      -- Better UI for LSP commands
      {
        'glepnir/lspsaga.nvim',
      },

      {
        'b0o/schemastore.nvim',
      },
    },

    config = function()
      require('config.lsp').config()
    end,
  },
}, {
  ui = {
    -- a number <1 is a percentage., >1 is a fixed size
    size = { width = 0.8, height = 0.8 },
    wrap = true, -- wrap the lines in the ui
    -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
    border = 'none',
    -- The backdrop opacity. 0 is fully opaque, 100 is fully transparent.
    backdrop = 60,
    title = nil, ---@type string only works when border is not "none"
    title_pos = 'center', ---@type "center" | "left" | "right"
    -- Show pills on top of the Lazy window
    pills = true, ---@type boolean
    icons = {
      cmd = ' ',
      config = '',
      event = ' ',
      ft = ' ',
      init = ' ',
      import = ' ',
      keys = ' ',
      lazy = '󰒲 ',
      loaded = '●',
      not_loaded = '○',
      plugin = ' ',
      runtime = ' ',
      require = '󰢱 ',
      source = ' ',
      start = ' ',
      task = '✔ ',
      list = {
        '●',
        '➜',
        '★',
        '‒',
      },
    },
  },
  performance = {
    rtp = {
      disabled_plugins = {
        '2html_plugin',
        'getscript',
        'getscriptPlugin',
        'gzip',
        'logiPat',
        'netrwPlugin',
        'rrhelper',
        'tar',
        'tarPlugin',
        'vimball',
        'vimballPlugin',
        'zip',
        'zipPlugin',
      },
    },
  },
  -- lazy can generate helptags from the headings in markdown readme files,
  -- so :help works even for plugins that don't have vim docs.
  -- when the readme opens with :help it will be correctly displayed as markdown
  readme = {
    enabled = true,
    root = vim.fn.stdpath('state') .. '/lazy/readme',
    files = { 'README.md', 'lua/**/README.md' },
    -- only generate markdown helptags for plugins that dont have docs
    skip_if_doc_exists = true,
  },
})

require('config.settings')
require('config.keymaps')
require('config.autocmd')
require('config.term').setup()
