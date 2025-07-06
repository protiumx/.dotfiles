local colors = require('config.colors')

local mode_text_map = {
  ['__'] = '--',
  ['c'] = 'C',
  ['i'] = 'I',
  ['ic'] = 'I-C',
  ['ix'] = 'I-X',
  ['multi'] = 'M',
  ['n'] = 'N',
  ['ni'] = '(I)',
  ['no'] = 'OP',
  ['R'] = 'R',
  ['Rv'] = 'V-R',
  ['s'] = 'S',
  ['S'] = 'S-L',
  [''] = 'S-B',
  ['t'] = 'T',
  ['v'] = 'V',
  ['V'] = 'V-L',
  [''] = 'V-B',
}

local base_theme = {
  a = { bg = 'none', fg = colors.foreground, gui = 'bold' },
  x = { bg = 'none', fg = colors.purple },
  y = { bg = 'none', fg = colors.light_grey },
  z = { bg = 'none', fg = colors.light_grey },
}

local theme = {
  normal = base_theme,
  insert = base_theme,
  visual = base_theme,
  replace = base_theme,
  inactive = {
    a = { bg = 'none', fg = colors.light_grey },
  },
}

return function()
  local file_section = {
    'filename',
    path = 1, -- relative path
    disabled_buftypes = { 'terminal', 'qf', 'prompt' },
    symbols = {
      modified = '[+]',
      readonly = '[-]',
      newfile = '[^]',
    },
  }

  require('lualine').setup({
    options = {
      icons_enabled = false,
      theme = theme,
      component_separators = '',
      section_separators = '',
      disabled_filetypes = {
        statusline = {
          'xterm',
          'TelescopePrompt',
          'guihua',
          'lspsagaoutline',
          'neo-tree',
          'neotest-summary',
          'noice',
          'packer',
          'tsplayground',
        },
      },
      ignore_focus = {},
      always_divide_middle = true,
      globalstatus = true,
      refresh = {
        statusline = 500,
        tabline = 1000,
        winbar = 1000,
      },
    },
    sections = {
      lualine_a = {
        {
          'mode',
          fmt = function()
            return mode_text_map[vim.fn.mode()] .. ' |'
          end,
        },
      },
      lualine_b = { file_section },
      lualine_c = {},
      lualine_x = {
        {
          'branch',
          fmt = function(s)
            if string.len(s) > 30 then
              return s:sub(1, 30) .. '..'
            end

            return '(' .. s .. ')'
          end,
        },
        -- Show icon if there are unsaved buffers
        {
          function()
            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
              if vim.api.nvim_get_option_value('modified', { buf = buf }) then
                return '󱃓'
              end
            end
            return ''
          end,
        },
      },
      lualine_y = {},
      lualine_z = {
        {
          require('noice').api.status.search.get,
          cond = require('noice').api.status.search.has,
          color = { fg = 'ff9e64' },
        },
        {
          require('noice').api.status.mode.get,
          cond = require('noice').api.status.mode.has,
          color = { fg = '#ff9e64' },
        },
        -- Position
        {
          function()
            return '%4l:%-3c %3p%%/%L'
          end,
        },
      },
    },
    inactive_sections = {
      lualine_a = { file_section },
      lualine_b = {},
      lualine_c = {},
      lualine_y = {},
      lualine_x = {},
      lualine_z = {},
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {},
    refresh = {
      statusline = 300,
    },
  })
end
