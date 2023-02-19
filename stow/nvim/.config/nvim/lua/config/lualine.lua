local colors = require('config.colors')
local M = {}

local modes = {
  ["__"] = "--",
  ["c"] = "C",
  ["i"] = "I",
  ["ic"] = "I-C",
  ["ix"] = "I-X",
  ["multi"] = "M",
  ["n"] = "N",
  ["ni"] = "(I)",
  ["no"] = "OP",
  ["R"] = "R",
  ["Rv"] = "V-R",
  ["s"] = "S",
  ["S"] = "S-L",
  [""] = "S-B",
  ["t"] = "T",
  ["v"] = "V",
  ["V"] = "V-L",
  [""] = "V-B",
}

local mode_colors = {
  n = colors.blue,
  i = colors.yellow,
  v = colors.magenta,
  [""] = colors.lightblue,
  [""] = colors.white,
  V = colors.lightblue,
  c = colors.orange,
  no = colors.magenta,
  s = colors.orange,
  S = colors.orange,
  -- [""] = colors.orange,
  ic = colors.yellow,
  R = colors.purple,
  Rv = colors.purple,
  cv = colors.orange,
  ce = colors.orange,
  r = colors.cyan,
  rm = colors.cyan,
  ["r?"] = colors.cyan,
  ["!"] = colors.cyan,
  t = colors.cyan,
}

local base_theme = {
  a = {},
  b = { bg = colors.background, fg = colors.blue },
  x = { fg = colors.purple, gui = 'bold' },
  y = { fg = colors.cyan },
  z = { fg = colors.light_grey },
}
local theme = {
  normal = base_theme,
  insert = base_theme,
  visual = base_theme,
  replace = base_theme,
  inactive = {
    a = { bg = colors.background, fg = colors.light_grey }
  },
}

local function lsp_symbol()
  return require('lspsaga.symbolwinbar'):get_winbar() or ''
end

function M.setup()
  local file_section = {
    'filename',
    path = 1,
    symbols = {
      modified = ' * ',
      readonly = '  ',
    }
  }
  require('lualine').setup {
    options = {
      icons_enabled = true,
      theme = theme,
      component_separators = '',
      section_separators = '',
      disabled_filetypes = {
        statusline = {
          'packer',
          'fugitive',
          'fugitiveblame',
          'qf',
          'help',
          'lspsagaoutline',
          'DiffviewFiles',
        },
      },
      ignore_focus = {},
      always_divide_middle = true,
      globalstatus = false,
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      }
    },
    sections = {
      lualine_a = {
        {
          'mode',

          fmt = function()
            return '| ' .. modes[vim.fn.mode()] .. ' '
          end,

          color = function()
            local val = {
              fg = mode_colors[vim.fn.mode()],
              bg = "#2c2c2c",
              gui = 'bold'
            }
            return val
          end,
        },
      },
      lualine_b = { file_section },
      lualine_c = { lsp_symbol },

      lualine_w = { 'diagnostics' },
      lualine_x = { 'branch' },
      lualine_y = { 'location' },
      lualine_z = { 'progress' },
    },
    inactive_sections = {
      lualine_a = { file_section },
      lualine_b = {},
      lualine_c = {},
      lualine_w = {},
      lualine_y = {},
      lualine_x = {},
      lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {},
    refresh = {
      statusline = 500,
    },
  }
end

return M
