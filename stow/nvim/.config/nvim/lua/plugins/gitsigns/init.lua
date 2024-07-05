local function on_attach(bufnr)
  local gs = package.loaded.gitsigns

  local function map(mode, l, r, desc)
    local opts = { silent = true, desc = desc, buffer = bufnr }
    vim.keymap.set(mode, l, r, opts)
  end

  -- Hunk Navigation
  vim.keymap.set('n', ']h', function()
    if vim.wo.diff then
      return ']h'
    end
    vim.schedule(function()
      gs.next_hunk()
    end)
    return '<Ignore>'
  end, { expr = true })

  vim.keymap.set('n', '[h', function()
    if vim.wo.diff then
      return '[h'
    end
    vim.schedule(function()
      gs.prev_hunk()
    end)
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
  map('v', '<C-g>hr', function()
    gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
  end)
  map('n', '<C-g>hp', gs.preview_hunk, '[Git] Preview hunk')
  map('n', '<C-g>br', gs.reset_buffer)

  -- Text object
  map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', '[Git] Hunk Text Object')
end

return {
  'lewis6991/gitsigns.nvim',
  event = 'VeryLazy',
  cond = function()
    return vim.fn.isdirectory(vim.fn.getcwd() .. '/.git/')
  end,
  init = function()
    vim.api.nvim_set_hl(0, 'GitSignsUntracked', { link = 'GitSignsAdd' })
    vim.api.nvim_set_hl(0, 'GitSignsUntrackedNr', { link = 'GitSignsAddNr' })
    vim.api.nvim_set_hl(0, 'GitSignsUntrackedLn', { link = 'GitSignsAddLn' })
  end,
  opts = {
    attach_to_untracked = true,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
      delay = 1000,
      ignore_whitespace = false,
    },
    on_attach = on_attach,
    preview_config = {
      -- Options passed to nvim_open_win
      border = 'solid',
      style = 'minimal',
      relative = 'cursor',
      row = 0,
      col = 1,
    },
    signs = {
      untracked = {
        text = '┃',
      },
    },
  },
}
