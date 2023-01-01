local servers = {
  tsserver = {},
  eslint = {},
  rust_analyzer = {},
  clangd = {},
  pyright = {},
  bashls = {},

  gopls = {
    gofumpt = true,
  },

  sumneko_lua = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      },
      workspace = {
        checkThirdParty = false,
        library = {
          [vim.fn.expand '$VIMRUNTIME/lua'] = true,
          [vim.fn.expand '$VIMRUNTIME/lua/vim/lsp'] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
      telemetry = { enable = false },
    },
  },
}

return servers
