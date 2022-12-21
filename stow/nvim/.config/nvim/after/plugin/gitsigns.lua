require('gitsigns').setup({
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    -- Actions
    map({'n', 'v'}, '<leader>gs', ':Gitsigns stage_hunk<CR>')
    map({'n', 'v'}, '<leader>gr', ':Gitsigns reset_hunk<CR>')
    map('n', '<leader>gS', gs.stage_buffer)
    map('n', '<leader>gu', gs.undo_stage_hunk)
    map('n', '<leader>gR', gs.reset_buffer)
    map('n', '<leader>gp', gs.preview_hunk)
    map('n', '<leader>gb', gs.blame_line)
    map('n', '<leader>gB', function() gs.blame_line{full=true} end)
    map('n', '<leader>glb', gs.toggle_current_line_blame)
    map('n', '<leader>gd', gs.diffthis)
    map('n', '<leader>gD', function() gs.diffthis('~') end)
    map('n', '<leader>gtd', gs.toggle_deleted)

    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
})
