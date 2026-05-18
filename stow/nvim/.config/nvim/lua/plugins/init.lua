local monoglow = {
  'wnkz/monoglow.nvim',
  lazy = false,
  priority = 1000,
  init = function()
    vim.cmd([[colorscheme monoglow]])
  end,
}

if vim.g.mini then
  return { monoglow }
end

return {
  require('plugins.conform'),
  require('plugins.diffview'),
  require('plugins.flash'),
  require('plugins.gitsigns'),
  require('plugins.lualine'),
  require('plugins.neoclip'),
  require('plugins.noice'),
  require('plugins.nvim-cmp'),
  require('plugins.telescope'),
  require('plugins.treesitter'),
  require('plugins.treesitter-textobjects'),
  require('plugins.treesj'),
  require('plugins.vim-sandwich'),
  monoglow,
  {
    'MunifTanjim/nui.nvim',
    lazy = false,
    priority = 1000,
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
