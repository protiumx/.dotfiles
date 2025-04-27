return {
  require('plugins.conform'),
  require('plugins.diffview'),
  require('plugins.gitsigns'),
  require('plugins.flash'),
  require('plugins.lualine'),
  require('plugins.neoclip'),
  require('plugins.neogit'),
  require('plugins.neotest'),
  require('plugins.neotree'),
  require('plugins.noice'),
  require('plugins.nvim-cmp'),
  require('plugins.nvim-dap'),
  require('plugins.telescope'),
  require('plugins.text-case'),
  require('plugins.treesitter'),
  require('plugins.treesj'),
  require('plugins.trouble'),
  require('plugins.vim-sandwich'),
  require('plugins.fidget'),
  require('plugins.lspsaga'),

  {
    'ellisonleao/gruvbox.nvim',
    enabled = false,
    config = function()
      local colors = require('config.colors')
      require('gruvbox').setup({
        undercurl = true,
        underline = true,
        bold = true,
        contrast = 'soft',
        palette_overrides = {
          dark0 = colors.background,
          dark1 = colors.background,
        },
        dim_inactive = false,
        transparent_mode = true,
      })
      vim.cmd('colorscheme gruvbox')
    end,
    lazy = false,
    priority = 1000,
  },
  {
    lazy = false,
    priority = 1000,
    'zenbones-theme/zenbones.nvim',
    dependencies = { 'rktjmp/lush.nvim' },
    config = function()
      vim.cmd('colorscheme zenwritten')
    end,
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
    enabled = false,
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
