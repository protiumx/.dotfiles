local M = {}

function M.setup()
  ---@diagnostic disable-next-line: redundant-parameter
  require('go').setup({
    comment_placeholder = '',
    gocoverage_sign = '┃',
    -- duplicate from ./init.lua
    diagnostic = {
      underline = false,
      severity_sort = true,
      signs = false,
      update_in_insert = true,
    },
    floaterm = {
      posititon = 'right', -- one of {`top`, `bottom`, `left`, `right`, `center`, `auto`}
      width = 0.5, -- width of float window if not auto
    },
    icons = false,
    -- virtual text setup
    lsp_document_formatting = true,
    lsp_inlay_hints = {
      enable = false,
    },
    lsp_keymaps = false,
    luasnip = true,
    max_line_len = 100,
    test_runner = 'go',
    run_in_floaterm = false,
  })

  vim.keymap.set('n', '<Leader>tp', '<cmd>GoTestPkg<CR>')
  vim.keymap.set('n', '<Leader>ga', '<cmd>GoAlt!<CR>')
  vim.keymap.set('n', '<Leader>gA', '<cmd>GoAltV!<CR>')
  vim.keymap.set('n', '<Leader>gi', '<cmd>GoImpl<CR>')
end

return M
