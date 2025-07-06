local utils = require('config.utils')

local zenbones = {
  lazy = false,
  priority = 1000,
  'zenbones-theme/zenbones.nvim',
  dependencies = { 'rktjmp/lush.nvim' },
  config = function()
    vim.cmd('colorscheme zenwritten')
  end,
}

if utils.is_git_commit() then
  return { zenbones }
end

return {
  require('plugins.conform'),
  require('plugins.diffview'),
  require('plugins.flash'),
  require('plugins.gitsigns'),
  require('plugins.lualine'),
  require('plugins.neoclip'),
  require('plugins.neogit'),
  require('plugins.neotest'),
  require('plugins.noice'),
  require('plugins.nvim-cmp'),
  require('plugins.telescope'),
  require('plugins.text-case'),
  require('plugins.treesitter'),
  require('plugins.treesj'),
  require('plugins.vim-sandwich'),
  require('plugins.yazi'),
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
    end,

    keys = {
      {
        '<C-w>S>',
        mode = 'n',
        function()
          local picked_window_id = require('window-picker').pick_window()
            or vim.api.nvim_get_current_win()
          vim.api.nvim_set_current_win(picked_window_id)
        end,
        desc = 'Pick a window',
      },
    },
  },
}
