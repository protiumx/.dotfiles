local config = require('config.lsp').config
return {
  'ray-x/go.nvim',
  ft = { 'go' },
  dependencies = {
    'ray-x/guihua.lua',
  },
  keys = {
    { '<Leader>tp', '<cmd>GoTestPkg<CR>' },
    { '<Leader>ga', '<cmd>GoAlt!<CR>' },
    { '<Leader>gA', '<cmd>GoAltV!<CR>' },
    { '<Leader>gi', '<cmd>GoImpl<CR>' },
  },
  opts = {
    comment_placeholder = '',
    dap_debug = false,
    -- duplicate from ./init.lua
    diagnostic = {
      virtual_text = config.virtual_text,
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
    lsp_codelens = false,
    lsp_inlay_hints = {
      enable = false,
    },
    lsp_keymaps = false,
    luasnip = false,
    run_in_floaterm = true,
    textobjects = false,
    test_runner = 'go',
    trouble = true,
  },
}
