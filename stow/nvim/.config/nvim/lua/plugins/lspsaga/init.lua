return {
  'glepnir/lspsaga.nvim',
  keys = {
    { 'gh', '<cmd>Lspsaga finder imp+def+ref<CR>', silent = true },
    { '<M-l>i', '<cmd>Lspsaga finder imp<CR>', silent = true },
    { '<M-l>r', '<cmd>Lspsaga finder ref<CR>', silent = true },
    { '<Leader>ca', '<cmd>Lspsaga code_action<CR>', mode = { 'n', 'v' }, silent = true },
    { 'gr', '<cmd>Lspsaga rename<CR>', silent = true },
    { 'gD', '<cmd>Lspsaga peek_definition<CR>', silent = true },
    { 'gT', '<cmd>Lspsaga peek_type_definition<CR>', silent = true },
    { '<C-g>d', '<cmd>Lspsaga show_buf_diagnostics<CR>', silent = true },
    { '<M-l>o', '<cmd>Lspsaga outline<CR>', silent = true },
  },
  opts = {
    preview = {
      lines_above = 0,
      lines_below = 10,
    },
    scroll_preview = {
      scroll_down = '<C-d>',
      scroll_up = '<C-u>',
    },
    lightbulb = {
      enable = false,
    },
    finder = {
      default = 'imp+def+ref',
      max_width = 0.6,
      left_width = 0.4,
      right_width = 0.6,
      keys = {
        toggle_or_open = '<CR>',
        vsplit = '<C-v>',
        split = '<C-x>',
        quit = '<ESC>',
        close = 'q',
      },
    },
    request_timeout = 2500,
    symbol_in_winbar = {
      enable = false, -- showing symbols in feline
      separator = '  ',
      hide_keyword = true,
      show_file = false,
    },
    hover = {
      max_width = 0.5,
    },
    definition = {
      keys = {
        edit = '<CR>',
        vsplit = '<C-v>',
        split = '<C-x>',
        quit = 'q',
      },
    },
    outline = {
      auto_preview = false,
      left_width = 0.3,
      win_width = 40,
      keys = {
        jump = '<CR>',
      },
    },
    diagnostic = {
      custom_fix = 'Code Actions',
      on_insert = false,
      on_insert_follow = false,
      max_width = 0.4,
      max_show_width = 0.7,
    },
    rename = {
      in_select = false,
      keys = {
        quit = '<C-c>',
      },
    },
    ui = {
      border = 'single',
      code_action = '',
      diagnostic = '',
      max_width = 0.6,
    },
  },
}
