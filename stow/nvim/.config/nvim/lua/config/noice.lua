local M = {}

function M.setup()
  require('noice').setup({
    views = {
      cmdline_popup = {
        relative = 'editor',
        border = {
          style = 'none',
          padding = { 1, 2 },
        },
        filter_options = {},
        win_options = {
          winhighlight = 'NormalFloat:NormalFloat,FloatBorder:FloatBorder',
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
          winhighlight = { Normal = 'NormalFloat', FloatBorder = 'FloatBorder' },
        },
      },
    },
    cmdline = {
      format = {
        cmdline = { pattern = '^:', icon = '', lang = '' },
        search_down = { kind = 'search', pattern = '^/', icon = '󰿟', lang = 'regex' },
        search_up = { kind = 'search', pattern = '^%?', icon = '?', lang = 'regex' },
        filter = false,
        lua = false,
        help = false,
      }
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
        }, -- merged with defaults from documentation
      },
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true,
      },
    },
    -- you can enable a preset for easier configuration
    presets = {
      bottom_search = false,        -- use a classic bottom cmdline for search
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false,           -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = true,        -- add a border to hover docs and signature help
    },
    -- add any options here
    routes = {
      {
        view = 'popup',
        filter = { event = 'msg_show', min_length = 100, min_height = 6 },
      },
    },
  })

  vim.keymap.set({ 'n', 'i', 's' }, '<C-d>', function()
    if not require('noice.lsp').scroll(4) then
      return '<C-d>'
    end
  end, { silent = true, expr = true })

  vim.keymap.set({ 'n', 'i', 's' }, '<C-u>', function()
    if not require('noice.lsp').scroll(-4) then
      return '<C-u>'
    end
  end, { silent = true, expr = true })
end

return M
