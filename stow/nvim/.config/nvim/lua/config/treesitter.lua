local M = {}

local function setup_text_objects()
  require('nvim-treesitter.configs').setup({
    textobjects = {
      select = {
        enable = true,
        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,
        keymaps = {
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          ['af'] = '@call.outer',
          ['if'] = '@call.inner',
          ['am'] = '@function.outer',
          ['im'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
          ['ai'] = '@conditional.outer',
          ['ii'] = '@conditional.inner',
          ['al'] = '@loop.outer',
          ['il'] = '@loop.inner',
        },
        -- You can choose the select mode (default is charwise 'v')
        --
        -- Can also be a function which gets passed a table with the keys
        -- * query_string: eg '@function.inner'
        -- * method: eg 'v' or 'o'
        -- and should return the mode ('v', 'V', or '<c-v>') or a table
        -- mapping query_strings to modes.
        selection_modes = 'v',
        -- If you set this to `true` (default is `false`) then any textobject is
        -- extended to include preceding or succeeding whitespace. Succeeding
        -- whitespace has priority in order to act similarly to eg the built-in
        -- `ap`.
        --
        -- Can also be a function which gets passed a table with the keys
        -- * query_string: eg '@function.inner'
        -- * selection_mode: eg 'v'
        -- and should return true of false
        include_surrounding_whitespace = false,
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>pn'] = '@parameter.inner',
          ['<leader>mn'] = '@function.outer',
        },
        swap_previous = {
          ['<leader>pp'] = '@parameter.inner',
          ['<leader>mp'] = '@function.outer',
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [']m'] = '@function.outer',
          [']c'] = '@class.outer',
          [']l'] = '@loop.outer',
          [']i'] = '@conditional.outer',
        },
        goto_next_end = {
          [']M'] = '@function.outer',
          [']C'] = '@class.outer',
          [']L'] = '@loop.outer',
          [']I'] = '@conditional.outer',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[c'] = '@class.outer',
          ['[l'] = '@loop.outer',
          ['[i'] = '@conditional.outer',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[C'] = '@class.outer',
          ['[L'] = '@loop.outer',
          ['[I'] = '@conditional.outer',
        },
      },
    },
  })
end

function M.setup()
  require('nvim-treesitter.configs').setup({
    -- A list of parser names, or 'all'
    ensure_installed = {
      'bash',
      'c',
      'comment',
      'cpp',
      'cue',
      'go',
      'javascript',
      'json',
      'lua',
      'markdown',
      'markdown_inline',
      'ocaml',
      'python',
      'regex',
      'rust',
      'sql',
      'svelte',
      'terraform',
      'toml',
      'typescript',
      'vim',
      'yaml',
    },
    sync_install = false,
    auto_install = false,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
  })

  setup_text_objects()
end

return M
