local M = {}

local function on_attach(bufnr)
  local gs = package.loaded.gitsigns

  local function map(mode, l, r, desc)
    local opts = { silent = true, desc = desc, buffer = bufnr }
    vim.keymap.set(mode, l, r, opts)
  end

  -- Hunk Navigation
  vim.keymap.set('n', ']h', function()
    if vim.wo.diff then return ']h' end
    vim.schedule(function() gs.next_hunk() end)
    return '<Ignore>'
  end, { expr = true })

  vim.keymap.set('n', '[h', function()
    if vim.wo.diff then return '[h' end
    vim.schedule(function() gs.prev_hunk() end)
    return '<Ignore>'
  end, { expr = true })

  -- Actions
  map('n', '<C-g>bl', gs.blame_line, '[Git] Blame line short')
  map('n', '<C-g>B', function()
    gs.blame_line({ full = true })
  end, '[Git] Blame line full')
  map('n', '<C-g>tb', gs.toggle_current_line_blame, '[Git] Toggle line blame')
  map('n', '<C-g>td', gs.toggle_deleted, '[Git] Toggle deleted preview')
  map('n', '<C-g>hr', gs.reset_hunk, '[Git] Reset hunk')
  map('v', '<C-g>hr', function() gs.reset_hunk { vim.fn.line("."), vim.fn.line("v") } end)
  map('n', '<C-g>hp', '<cmd>Gitsigns preview_hunk<CR>', '[Git] Blame line short')
  map('n', '<C-g>br', gs.reset_buffer)

  -- Text object
  map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', '[Git] Hunk Text Object')
end

function M.setup()
  require('gitsigns').setup({
    on_attach = on_attach,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
      delay = 1000,
      ignore_whitespace = false,
    },
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
