local M = {}

local function on_attach(bufnr)
  local gs = package.loaded.gitsigns

  local function map(mode, l, r, desc)
    local opts = { silent = true, desc = desc, bufnr = bufnr }
    vim.keymap.set(mode, l, r, opts)
  end

  -- Hunk Navigation
  vim.keymap.set('n', ']c', function()
    if vim.wo.diff then return ']c' end
    vim.schedule(function() gs.next_hunk() end)
    return '<Ignore>'
  end, { expr = true })

  vim.keymap.set('n', '[c', function()
    if vim.wo.diff then return '[c' end
    vim.schedule(function() gs.prev_hunk() end)
    return '<Ignore>'
  end, { expr = true })

  -- Actions
  map('n', '<Leader>gp', gs.preview_hunk, '[Git] Preview hunk')
  map('n', '<Leader>gb', gs.blame_line, '[Git] Blame line short')
  map('n', '<Leader>gB', function()
    gs.blame_line({ full = true })
  end, '[Git] Blame line full')

  map('n', '<Leader>glb', gs.toggle_current_line_blame, '[Git] Toggle line blame')
  map('n', '<Leader>gd', gs.diffthis, '[Git] Show diff of current file')
  -- TODO: make it usable
  map('n', '<Leader>gD', function()
    gs.diffthis('~')
  end)

  map('n', '<Leader>gtd', gs.toggle_deleted, '[Git] Toggle deleted preview')

  -- Text object
  map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', '[Git] Hunk Text Object')
end

function M.setup()
  require('gitsigns').setup({
    on_attach = on_attach,
    signs = {
      untracked = {
        hl = 'GitSignsAdd',
        text = '┃',
        numhl = 'GitSignsAddNr',
        linehl = 'GitSignsAddLn',
      },
    },
  })
end

return M
