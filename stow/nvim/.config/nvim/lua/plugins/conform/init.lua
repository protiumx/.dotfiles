return {
  'stevearc/conform.nvim',
  config = function()
    require('plugins.conform.config')()
  end,
  opts = {
    format_on_save = {
      timeout_ms = 1000,
      lsp_fallback = true,
    },
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'black' },
      ocaml = { 'ocamlformat' },
      javascript = { 'prettier' },
      json = { 'prettier' },
      html = { 'prettier' },
      markdown = { 'prettier' },
      go = { 'gofumpt', 'goimports' }, -- runs both
    },
  },
}
