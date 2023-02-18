local M = {}

local colors = {
  bg = '#1c1c1c',
  fg = '#abb2bf',
  yellow = '#e0af68',
  cyan = '#56b6c2',
  darkblue = '#081633',
  green = '#98c379',
  orange = '#d19a66',
  violet = '#a9a1e1',
  magenta = '#c678dd',
  blue = '#61afef',
  red = '#e86671'
}

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
  b = { bg = colors.bg, fg = colors.blue },
  x = { fg = colors.magenta, gui = 'bold' },
  y = { fg = colors.cyan },
  z = { fg = colors.fg },
}
local theme = {
  normal = base_theme,
  insert = base_theme,
  visual = base_theme,
  replace = base_theme,
  inactive = base_theme,
}

function lsp_symbol()
  return require('lspsaga.symbolwinbar'):get_winbar() or ''
end

function M.setup()
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
      lualine_b = {
        {
          'filename',
          path = 1,
          symbols = {
            modified = ' * ',
            readonly = '  ',
          }
        },
      },
      lualine_c = { lsp_symbol },

      lualine_w = { 'diagnostics' },
      lualine_x = { 'branch' },
      lualine_y = { 'location' },
      lualine_z = { 'progress' },
    },
    inactive_sections = {
      lualine_a = { 'filename' },
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
