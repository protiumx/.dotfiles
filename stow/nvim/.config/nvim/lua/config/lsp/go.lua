local M = {}

function M.setup()
  ---@diagnostic disable-next-line: redundant-parameter
  require('go').setup({
    icons = false,
    comment_placeholder = '',
    max_line_len = 100,
    lsp_diag_hdlr = false,
    lsp_diag_underline = false,
    -- virtual text setup
    lsp_diag_virtual_text = false,
    lsp_diag_signs = false,
    lsp_diag_update_in_insert = false,
    lsp_document_formatting = true,
    lsp_inlay_hints = {
      enable = false,
    },
    -- test_runner = 'gotestsum',
    run_in_floaterm = true,
    luasnip = true,
    floaterm = {
      posititon = 'right', -- one of {`top`, `bottom`, `left`, `right`, `center`, `auto`}
      width = 0.4,         -- width of float window if not auto
    },
  })

  vim.keymap.set('n', '<Leader>tF', '<cmd>GoTestFile<CR>')
  vim.keymap.set('n', '<Leader>tf', '<cmd>GoTestFunc<CR>')
  vim.keymap.set('n', '<Leader>tp', '<cmd>GoTestPkg<CR>')
  vim.keymap.set('n', '<Leader>ga', '<cmd>GoAlt!<CR>')
  vim.keymap.set('n', '<Leader>gA', '<cmd>GoAltV!<CR>')
  vim.keymap.set('n', '<Leader>gi', '<cmd>GoImpl<CR>')
end

return M
