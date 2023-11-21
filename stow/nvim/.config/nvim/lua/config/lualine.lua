local colors = require('config.colors')
local M = {}

local modes = {
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

local mode_colors = {
  n = colors.blue,
  i = colors.yellow,
  v = colors.magenta,
  [''] = colors.lightblue,
  [''] = colors.white,
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
  ['r?'] = colors.cyan,
  ['!'] = colors.cyan,
  t = colors.cyan,
}

local base_theme = {
  a = {},
  b = { bg = 'none', fg = colors.blue },
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

local function lsp_symbol()
  return require('lspsaga.symbol.winbar'):get_bar() or ''
end

function M.setup()
  local file_section = {
    'filename',
    path = 1,
    disabled_buftypes = { 'terminal' },
    symbols = {
      modified = '[+]',
      readonly = '',
      newfile = '',
    },
  }

  require('lualine').setup({
    options = {
      icons_enabled = true,
      theme = theme,
      component_separators = '',
      section_separators = '',
      disabled_filetypes = {
        statusline = {
          'FTerm',
          'TelescopePrompt',
          'guihua',
          'lspsagaoutline',
          'neo-tree',
          'neotest-summary',
          'noice',
          'packer',
          'qf',
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
            return modes[vim.fn.mode()] .. ' |'
          end,
          color = function()
            local val = {
              fg = mode_colors[vim.fn.mode()],
              bg = 'none',
              gui = 'bold',
            }
            return val
          end,
        },
      },
      lualine_b = { file_section },
      lualine_c = {
        {
          lsp_symbol,
          cond = function()
            return next(vim.lsp.buf_get_clients(0)) ~= nil
          end,
        },
      },
      lualine_x = {
        {
          'branch',
          fmt = function(s)
            if string.len(s) > 30 then
              return s:sub(1, 30) .. '..'
            end

            return s
          end,
        },
        {
          function()
            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
              if vim.api.nvim_buf_get_option(buf, 'modified') then
                return '󱃓'
              end
            end
            return ''
          end,
        },
      },
      lualine_y = { { 'diagnostics', sources = { 'nvim_diagnostic' } } },
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
        { 'location' },
        { 'progress', fmt = string.lower },
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

return M
