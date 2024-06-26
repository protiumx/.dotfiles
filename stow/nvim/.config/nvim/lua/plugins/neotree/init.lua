return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  cmd = 'Neotree',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
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

        vim.keymap.set('n', '<C-w>S', function()
          local picked_window_id = picker.pick_window() or vim.api.nvim_get_current_win()
          vim.api.nvim_set_current_win(picked_window_id)
        end, { desc = 'Pick a window' })
      end,
    },
  },
  keys = {
    {
      '<M-T>',
      '<cmd>Neotree toggle reveal<CR>',
      mode = { 'n', 'i' },
      desc = 'Toggle Neotree',
    },
    {
      '<C-b>',
      '<cmd>Neotree toggle source=buffers reveal<CR>',
      mode = { 'n', 'i' },
      desc = 'Toggle Neotree Buffers',
    },
  },
  opts = {
    close_if_last_window = true,
    popup_border_style = 'single',
    enable_git_status = true,
    enable_diagnostics = true,
    open_files_do_not_replace_types = { 'terminal', 'qf' }, -- when opening files, do not use windows containing these filetypes or buftypes
    sort_case_insensitive = false, -- used when sorting files and directories in the tree
    source_selector = {
      winbar = true,
    },
    default_component_configs = {
      container = {
        enable_character_fade = true,
      },
      indent = {
        indent_size = 2,
        padding = 1, -- extra padding on left hand side
        -- indent guides
        with_markers = true,
        indent_marker = '│',
        last_indent_marker = '└',
        highlight = 'NeoTreeIndentMarker',
        -- expander config, needed for nesting files
        with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
        expander_collapsed = '',
        expander_expanded = '',
        expander_highlight = 'NeoTreeExpander',
      },
      icon = {
        folder_closed = '',
        folder_open = '',
        folder_empty = '',
        highlight = 'NeoTreeFileIcon',
      },
      modified = {
        symbol = '[+]',
        highlight = 'NeoTreeModified',
      },
      name = {
        trailing_slash = false,
        use_git_status_colors = true,
        highlight = 'NeoTreeFileName',
      },
      git_status = {
        symbols = {
          -- Change type
          added = '',
          modified = '~',
          deleted = 'x',
          renamed = '>',
          -- Status type
          untracked = '?',
          ignored = '',
          unstaged = '-',
          staged = '+',
          conflict = '',
        },
      },
    },
    document_symbols = {
      follow_cursor = true,
      client_filters = 'first',
      kinds = {
        File = { icon = '󰈙', hl = 'Tag' },
        Namespace = { icon = '󰌗', hl = 'Include' },
        Package = { icon = '󰏖', hl = 'Label' },
        Class = { icon = '󰌗', hl = 'Include' },
        Property = { icon = '󰆧', hl = '@property' },
        Enum = { icon = '󰒻', hl = '@number' },
        Function = { icon = '󰊕', hl = 'Function' },
        String = { icon = '󰀬', hl = 'String' },
        Number = { icon = '󰎠', hl = 'Number' },
        Array = { icon = '󰅪', hl = 'Type' },
        Object = { icon = '󰅩', hl = 'Type' },
        Key = { icon = '󰌋', hl = '' },
        Struct = { icon = '󰌗', hl = 'Type' },
        Operator = { icon = '󰆕', hl = 'Operator' },
        TypeParameter = { icon = '󰊄', hl = 'Type' },
        StaticMethod = { icon = '󰠄 ', hl = 'Function' },
      },
    },
    commands = {
      system_open = function(state)
        local node = state.tree:get_node()
        local path = node:get_id()
        -- macOs: open file in default application in the background.
        vim.fn.jobstart({ 'xdg-open', '-g', path }, { detach = true })
      end,
    },
    window = {
      position = 'left',
      width = 40,
      mapping_options = {
        noremap = true,
        nowait = true,
      },
      mappings = {
        ['<space>'] = {
          'toggle_node',
          nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
        },
        ['<2-LeftMouse>'] = 'open',
        ['<cr>'] = 'open',
        ['<esc>'] = 'revert_preview',
        ['P'] = { 'toggle_preview', config = { use_float = true } },
        ['l'] = 'focus_preview',
        ['S'] = 'open_split',
        ['s'] = 'open_vsplit',
        ['<C-S>'] = 'split_with_window_picker',
        ['<C-s>'] = 'vsplit_with_window_picker',
        ['w'] = 'open_with_window_picker',
        ['C'] = 'close_node',
        -- ['C'] = 'close_all_subnodes',
        ['z'] = 'close_all_nodes',
        --['Z'] = 'expand_all_nodes',
        ['a'] = {
          'add',
          -- this command supports BASH style brace expansion ('x{a,b,c}' -> xa,xb,xc). see `:h neo-tree-file-actions` for details
          -- some commands may take optional config options, see `:h neo-tree-mappings` for details
          config = {
            show_path = 'none', -- 'none', 'relative', 'absolute'
          },
        },
        ['A'] = 'add_directory', -- also accepts the optional config.show_path option like 'add'. this also supports BASH style brace expansion.
        ['d'] = 'delete',
        ['r'] = 'rename',
        -- ['y'] = 'copy_to_clipboard',
        -- ['x'] = 'cut_to_clipboard',
        -- ['p'] = 'paste_from_clipboard',
        -- ['c'] = 'copy', -- takes text input for destination, also accepts the optional config.show_path option like 'add':
        ['c'] = {
          'copy',
          config = {
            show_path = 'none', -- 'none', 'relative', 'absolute'
          },
        },
        ['m'] = 'move', -- takes text input for destination, also accepts the optional config.show_path option like 'add'.
        ['q'] = 'close_window',
        ['R'] = 'refresh',
        ['?'] = 'show_help',
        ['<'] = 'prev_source',
        ['>'] = 'next_source',
        ['o'] = 'system_open',
      },
    },
    nesting_rules = {},
    filesystem = {
      filtered_items = {
        visible = false, -- when true, they will just be displayed differently than normal items
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_hidden = false, -- only works on Windows for hidden files/directories
        hide_by_name = {
          --'node_modules'
        },
        hide_by_pattern = { -- uses glob style patterns
          --'*.meta',
          --'*/src/*/tsconfig.json',
        },
        always_show = { -- remains visible even if other settings would normally hide it
          --'.gitignored',
        },
        never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
          '.git/',
        },
        never_show_by_pattern = { -- uses glob style patterns
          '.git/*',
        },
      },
      follow_current_file = {
        enable = true,
      },
      -- time the current file is changed while the tree is open.
      group_empty_dirs = false, -- when true, empty folders will be grouped together
      hijack_netrw_behavior = 'disabled', -- netrw disabled, opening a directory opens neo-tree
      use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
      -- instead of relying on nvim autocmd events.
      window = {
        mappings = {
          ['<bs>'] = 'navigate_up',
          ['.'] = 'set_root',
          ['H'] = 'toggle_hidden',
          ['/'] = 'fuzzy_finder',
          ['D'] = 'fuzzy_finder_directory',
          ['#'] = 'fuzzy_sorter', -- fuzzy sorting using the fzy algorithm
          -- ['D'] = 'fuzzy_sorter_directory',
          ['f'] = 'filter_on_submit',
          ['<c-x>'] = 'clear_filter',
          ['[g'] = 'prev_git_modified',
          [']g'] = 'next_git_modified',
        },
        fuzzy_finder_mappings = {
          -- define keymaps for filter popup window in fuzzy_finder_mode
          ['<down>'] = 'move_cursor_down',
          ['<C-n>'] = 'move_cursor_down',
          ['<up>'] = 'move_cursor_up',
          ['<C-p>'] = 'move_cursor_up',
        },
      },
      commands = {}, -- Add a custom command or override a global one using the same function name
    },
    buffers = {
      follow_current_file = {
        enabled = true,
      },
      -- time the current file is changed while the tree is open.
      group_empty_dirs = false, -- when true, empty folders will be grouped together
      show_unloaded = true,
      window = {
        mappings = {
          ['d'] = 'buffer_delete',
          ['<bs>'] = 'navigate_up',
        },
      },
    },
    git_status = {
      window = {
        position = 'float',
        mappings = {
          ['A'] = 'git_add_all',
          ['gu'] = 'git_unstage_file',
          ['ga'] = 'git_add_file',
          ['gr'] = 'git_revert_file',
          ['gc'] = 'git_commit',
          ['gp'] = 'git_push',
          ['gg'] = 'git_commit_and_push',
        },
      },
    },
  },
}
