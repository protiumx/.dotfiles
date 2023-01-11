local M = {}

local function on_attach(bufnr)
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
  end, { expr = true })

  map('n', '[c', function()
    if vim.wo.diff then return '[c' end
    vim.schedule(function() gs.prev_hunk() end)
    return '<Ignore>'
  end, { expr = true })

  -- Actions
  map('n', '<Leader>gp', gs.preview_hunk)
  map('n', '<Leader>gb', gs.blame_line)
  map('n', '<Leader>gB', function() gs.blame_line({ full = true }) end)
  map('n', '<Leader>glb', gs.toggle_current_line_blame)
  map('n', '<Leader>gd', gs.diffthis)
  -- TODO: make it usable
  map('n', '<Leader>gD', function() gs.diffthis('~') end)
  map('n', '<Leader>gtd', gs.toggle_deleted)

  -- Text object
  map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
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
