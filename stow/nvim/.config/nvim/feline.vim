lua << EOF
if not pcall(require, "feline") then
  return
end

local colors = {
  bg = '#3C474E',  
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
        left = {
            provider = function()
              return '▌ ' .. modes[vim.fn.mode()]
            end,
            hl = function()
                local val = {
                    fg = mode_colors[vim.fn.mode()],
                    style = 'bold'
                }
                return val
            end,
            right_sep = ' '
        },
    },
    file = {
        info = {
            provider = {
              name = 'file_info',
              opts = {
                type = 'relative',
                file_readonly_icon = '  ',
                file_modified_icon = ' * ',
                icons = true
              }
            },
            left_sep = ' ',
            hl = {
                fg = colors.blue,
                style = 'bold'
            }
        },
        encoding = {
            provider = 'file_encoding',
            left_sep = ' ',
            hl = {
                fg = colors.violet,
                style = 'bold'
            }
        },
        position = {
            provider = {
              name = "position",
              opts = {
                format = "↓{line} →{col}",
              },
            },
            left_sep = ' ',
            hl = {
                fg = colors.cyan,
                -- style = 'bold'
            }
        },
    },

    line_percentage = {
        provider = 'line_percentage',
        left_sep = ' ',
        hl = {
            style = 'bold'
        }
    },
    scroll_bar = {
        provider = 'scroll_bar',
        left_sep = ' ',
        hl = {
            fg = colors.blue,
            style = 'bold'
        }
    },

    git = {
        branch = {
            provider = 'git_branch',
            icon = ' ',
            left_sep = ' ',
            right_sep = ' ',
            hl = {
                fg = colors.violet,
                style = 'bold'
            },
        },
        add = {
            provider = 'git_diff_added',
            hl = {
                fg = colors.green
            }
        },
        change = {
            provider = 'git_diff_changed',
            hl = {
                fg = colors.orange
            }
        },
        remove = {
            provider = 'git_diff_removed',
            hl = {
                fg = colors.red
            }
        }
    }
}

local components = {
  active = {},
  inactive = {},
}

table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.inactive, {})
table.insert(components.inactive, {})
table.insert(components.inactive, {})

table.insert(components.active[1], comps.vi_mode.left)
table.insert(components.active[1], comps.git.branch)
table.insert(components.active[1], comps.git.add)
table.insert(components.active[1], comps.git.change)
table.insert(components.active[1], comps.git.remove)
table.insert(components.active[1], comps.file.info)
table.insert(components.inactive[1], comps.vi_mode.left)
table.insert(components.inactive[1], comps.file.info)
table.insert(components.active[3], comps.file.encoding)
table.insert(components.active[3], comps.file.position)
table.insert(components.active[3], comps.line_percentage)
table.insert(components.active[3], comps.scroll_bar)

require'feline'.setup {
    colors = colors,
    components = components,
    vi_mode_colors = mode_colors,
    disable = {
        filetypes = {
            'packer',
            'NvimTree',
            'fugitive',
            'fugitiveblame'
        },
        buftypes = {'terminal'},
        bufnames = {}
    }
}
require('feline').use_theme(colors)
EOF
