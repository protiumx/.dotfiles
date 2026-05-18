return {
  'nvim-treesitter/nvim-treesitter-textobjects',
  branch = 'main',
  init = function()
    vim.g.no_plugin_maps = true
  end,
  config = function()
    require('nvim-treesitter-textobjects').setup({
      select = {
        lookahead = true,
      },

      move = {
        -- whether to set jumps in the jumplist
        set_jumps = true,
      },
    })

    local to = require('nvim-treesitter-textobjects.select')

    local select_keymaps = {
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
    }

    for m, o in pairs(select_keymaps) do
      vim.keymap.set({ 'x', 'o' }, m, function()
        to.select_textobject(o, 'textobjects')
      end, { desc = '[treesitter] select ' .. o })
    end

    local swap_next = {
      ['<leader>pn'] = '@parameter.inner',
      ['<leader>mn'] = '@function.outer',
    }
    for m, o in pairs(swap_next) do
      vim.keymap.set('n', m, function()
        require('nvim-treesitter-textobjects.swap').swap_next(o)
      end, { desc = '[treesitter] swap ' .. o })
    end

    local swap_previous = {
      ['<leader>pp'] = '@parameter.inner',
      ['<leader>mp'] = '@function.outer',
    }
    for m, o in pairs(swap_previous) do
      vim.keymap.set('n', m, function()
        require('nvim-treesitter-textobjects.swap').swap_previous(o)
      end, { desc = '[treesitter] swap ' .. o })
    end

    local goto_next_start = {
      [']m'] = '@function.outer',
      [']c'] = '@class.outer',
      [']l'] = '@loop.outer',
      [']i'] = '@conditional.outer',
    }
    for m, o in pairs(goto_next_start) do
      vim.keymap.set({ 'n', 'x', 'o' }, m, function()
        require('nvim-treesitter-textobjects.move').goto_next_start(o, 'textobjects')
      end, { desc = '[treesitter] goto next start' .. o })
    end

    local goto_next_end = {
      [']M'] = '@function.outer',
      [']C'] = '@class.outer',
      [']L'] = '@loop.outer',
      [']I'] = '@conditional.outer',
    }
    for m, o in pairs(goto_next_end) do
      vim.keymap.set({ 'n', 'x', 'o' }, m, function()
        require('nvim-treesitter-textobjects.move').goto_next_end(o, 'textobjects')
      end, { desc = '[treesitter] goto next end' .. o })
    end

    local goto_previous_start = {
      ['[m'] = '@function.outer',
      ['[c'] = '@class.outer',
      ['[l'] = '@loop.outer',
      ['[i'] = '@conditional.outer',
    }
    for m, o in pairs(goto_previous_start) do
      vim.keymap.set({ 'n', 'x', 'o' }, m, function()
        require('nvim-treesitter-textobjects.move').goto_previous_start(o, 'textobjects')
      end, { desc = '[treesitter] goto prev start' .. o })
    end

    local goto_previous_end = {
      ['[M'] = '@function.outer',
      ['[C'] = '@class.outer',
      ['[L'] = '@loop.outer',
      ['[I'] = '@conditional.outer',
    }
    for m, o in pairs(goto_previous_end) do
      vim.keymap.set({ 'n', 'x', 'o' }, m, function()
        require('nvim-treesitter-textobjects.move').goto_previous_end(o, 'textobjects')
      end, { desc = '[treesitter] goto prev end' .. o })
    end
  end,
  dependencies = { 'nvim-treesitter' },
}
