lua << EOF
if not pcall(require, "feline") then
  return
end

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

local comps = {
    vi_mode = {
      provider = function()
        return '| ' .. modes[vim.fn.mode()] .. '  '
      end,
      hl = function()
          local val = {
              fg = mode_colors[vim.fn.mode()],
              bg = "#2c2c2c",
              style = 'bold'
          }
          return val
      end,
      right_sep = '  '
    },

    file = {
      info = {
          provider = {
            name = 'file_info',
            opts = {
              type = 'relative',
              file_readonly_icon = '  ',
              file_modified_icon = ' * ',
            }
          },
          icon = '',
          right_sep = '',
          hl = {
              -- bg = '#2c2c2c',
              fg = colors.blue,
          }
      },

      encoding = {
          provider = 'file_encoding',
          left_sep = ' ',
          hl = {
              fg = colors.violet,
          }
      },

      position = {
          provider = {
            name = "position",
            opts = {
              format = "{line}:{col}",
            },
          },
          left_sep = ' ',
          hl = {
              fg = colors.cyan,
          }
      },
    },

    line_percentage = {
      provider = 'line_percentage',
      left_sep = ' ',
      hl = {},
    },
}

local components = {
  active = {
    {},
    {},
  },
  inactive = {
    {},
    {},
  },
}

table.insert(components.active[1], comps.vi_mode)
table.insert(components.active[1], comps.file.info)
table.insert(components.active[1], {})

table.insert(components.active[2], comps.file.encoding)
table.insert(components.active[2], comps.file.position)
table.insert(components.active[2], comps.line_percentage)

table.insert(components.inactive[1], comps.vi_mode)
table.insert(components.inactive[1], comps.file.info)

local f = require 'feline'
f.setup {
    colors = colors,
    components = components,
    vi_mode_colors = mode_colors,
    disable = {
        filetypes = {
          '^NvimTree$',
          '^packer$',
          '^startify$',
          '^fugitive$',
          '^fugitiveblame$',
          '^qf$',
          '^help$'
        },
        buftypes = {'^terminal$'},
        bufnames = {}
    }
}
f.use_theme(colors)
EOF
