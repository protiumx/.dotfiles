return {
  require('plugins.conform'),
  require('plugins.diffview'),
  require('plugins.gitsigns'),
  require('plugins.hop'),
  require('plugins.lualine'),
  require('plugins.neoclip'),
  require('plugins.neogit'),
  require('plugins.neotest'),
  require('plugins.neotree'),
  require('plugins.noice'),
  require('plugins.nvim-cmp'),
  require('plugins.nvim-dap'),
  require('plugins.nvim-go'),
  require('plugins.telescope'),
  require('plugins.text-case'),
  require('plugins.treesitter'),
  require('plugins.treesj'),
  require('plugins.trouble'),
  require('plugins.vim-sandwich'),

  {
    'ellisonleao/gruvbox.nvim',
    lazy = false,
    priority = 1000,
  },
  -- {
  --   'cranberry-clockworks/coal.nvim',
  --   config = function()
  --       require('coal').setup({
  --         -- colors = {
  --         --   anti_flash_white = '#cfcbc9'
  --         -- }
  --       })
  --   end
  -- },
  {
    'zenbones-theme/zenbones.nvim',
    init = function()
      vim.g['zenbones_compat'] = 1
    end,
    config = function()
      vim.cmd('colorscheme zenwritten')
    end,
    dependencies = { 'rktjmp/lush.nvim' },
  },

  {
    'MunifTanjim/nui.nvim',
    lazy = false,
    priority = 1000,
  },

  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    event = 'VeryLazy',
    dependencies = { 'nvim-treesitter' },
  },

  {
    'mbbill/undotree',
    event = 'VeryLazy',
    config = function()
      vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
    end,
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
    'norcalli/nvim-colorizer.lua',
    cmd = { 'ColorizerToggle' },
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
    'nvim-tree/nvim-web-devicons',
    event = 'VeryLazy',
    opts = {
      color_icons = true,
    },
  },
}
