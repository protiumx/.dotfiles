local ui = require('config.ui')

local win_highlights = {
  NormalFloat = 'NormalFloat',
  FloatBorder = 'FloatBorder',
}

return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'rcarriga/nvim-notify',
  },
  keys = {
    {
      '<C-d>',
      function()
        if not require('noice.lsp').scroll(4) then
          return '<C-d>'
        end
      end,
      mode = { 'n', 'i', 's' },
      silent = true,
      expr = true,
    },

    {
      '<C-u>',
      function()
        if not require('noice.lsp').scroll(-4) then
          return '<C-u>'
        end
      end,
      mode = { 'n', 'i', 's' },
      silent = true,
      expr = true,
    },
  },
  opts = {
    views = {
      cmdline_popup = {
        relative = 'editor',
        border = {
          style = 'none',
          padding = { 1, 2 },
        },
        filter_options = {},
        win_options = {
          winhighlight = win_highlights,
        },
        position = {
          row = '42%',
          col = '50%',
        },
        size = {
          width = 60,
          height = 'auto',
        },
      },

      popupmenu = {
        relative = 'editor',
        size = {
          width = 60,
          height = 'auto',
        },
        position = 'auto',
        border = {
          padding = { 1, 2 },
        },
        win_options = {
          winhighlight = win_highlights,
        },
      },

      popup = {
        border = {
          style = 'solid',
        },
        win_options = {
          linebreak = true,
          winblend = ui.winblend,
          wrap = true,
          winhighlight = win_highlights,
        },
      },

      messages = {
        view = 'popup',
        relative = 'editor',
        border = {
          style = 'none',
          padding = { 1, 2 },
        },
        win_options = {
          wrap = true,
          winblend = ui.winblend,
          linebreak = true,
          winhighlight = win_highlights,
        },
      },

      hover = {
        view = 'popup',
        relative = 'cursor',
        border = {
          style = 'none',
          padding = { 1, 2 },
        },
        position = { row = 2, col = 0 },
        win_options = {
          wrap = true,
          winblend = 0,
          linebreak = true,
          winhighlight = win_highlights,
        },
      },
    },

    cmdline = {
      format = {
        cmdline = { pattern = '^:', icon = ':', lang = '' },
        search_down = { kind = 'search', pattern = '^/', icon = '/', lang = 'regex' },
        search_up = { kind = 'search', pattern = '^%?', icon = '?', lang = 'regex' },
        filter = false,
        lua = false,
        help = false,
      },
    },

    messages = {
      view_search = false,
      view_history = 'popup',
    },

    lsp = {
      progress = {
        enabled = false,
      },

      hover = {
        enabled = true,
        view = 'hover', -- when nil, use defaults from documentation
        opts = {
          focusable = true,
          scrollbar = true,
        }, -- merged with defaults from documentation
      },

      signature = {
        enabled = true,
        opts = {
          position = {
            row = 2, -- show below the current line
          },
        },
      },

      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = false,
      },
    },

    presets = {
      bottom_search = false, -- use a classic bottom cmdline for search
      long_message_to_split = false, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = false, -- add a border to hover docs and signature help
    },

    routes = {
      -- route messages larger than 100 chars or 6 lines to popup
      {
        filter = { event = 'msg_show', min_length = 20, min_height = 6 },
        view = 'popup',
      },
    },
  },
}
