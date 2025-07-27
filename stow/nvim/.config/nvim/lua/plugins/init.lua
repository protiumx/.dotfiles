local zenbones = {
  lazy = false,
  priority = 1000,
  'zenbones-theme/zenbones.nvim',
  dependencies = { 'rktjmp/lush.nvim' },
  config = function()
    vim.cmd('colorscheme zenwritten')
  end,
}

if vim.g.mini then
  return { zenbones }
end

return {
  require('plugins.conform'),
  require('plugins.diffview'),
  require('plugins.flash'),
  require('plugins.gitsigns'),
  require('plugins.lualine'),
  require('plugins.neoclip'),
  require('plugins.neotest'),
  require('plugins.noice'),
  require('plugins.nvim-cmp'),
  require('plugins.nvim-lint'),
  require('plugins.telescope'),
  require('plugins.treesitter'),
  require('plugins.treesj'),
  require('plugins.vim-sandwich'),
  zenbones,
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
