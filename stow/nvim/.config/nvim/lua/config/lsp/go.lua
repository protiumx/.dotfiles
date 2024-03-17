local M = {}

function M.setup()
  ---@diagnostic disable-next-line: redundant-parameter
  require('go').setup({
    comment_placeholder = '',
    dap_debug = false,
    -- duplicate from ./init.lua
    diagnostic = {
      virtual_text = true,
      underline = false,
      severity_sort = true,
      signs = false,
      update_in_insert = true,
    },
    floaterm = {
      posititon = 'right',
      width = 0.5,
    },
    gofmt = 'gofumpt',
    gocoverage_sign = '┃',
    icons = false,
    lsp_cfg = false,
    lsp_document_formatting = false,
    lsp_inlay_hints = {
      enable = false,
      title_colors = 'nord',
    },
    lsp_keymaps = false,
    luasnip = true,
    run_in_floaterm = true,
    test_runner = 'go',
    trouble = true,
  })

  vim.keymap.set('n', '<Leader>tp', '<cmd>GoTestPkg<CR>')
  vim.keymap.set('n', '<Leader>ga', '<cmd>GoAlt!<CR>')
  vim.keymap.set('n', '<Leader>gA', '<cmd>GoAltV!<CR>')
  vim.keymap.set('n', '<Leader>gi', '<cmd>GoImpl<CR>')
end

return M
