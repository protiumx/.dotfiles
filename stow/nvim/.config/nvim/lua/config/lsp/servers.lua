local servers = {
  dockerls = {},
  graphql = {},
  tsserver = {},
  eslint = {},
  rust_analyzer = {},
  clangd = {},
  pyright = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = 'workspace',
        useLibraryCodeForTypes = true
      },
    }
  },
  yamlls = {
    yaml = {
      format = {
        enable = false,
        proseWrap = 'never',
        printWidth = 200,
      },
      validate = true,
      schemaStore = {
        enable = true,
      },
    },
  },
  terraformls = {},
  bashls = {
    cmd_env = {
      GLOB_PATTERN = '*@(.sh|.inc|.bash|.command|.zsh)',
    },
    filetypes = { 'sh', 'zsh' },
  },
  gopls = {
    gofumpt = true,
    experimentalPostfixCompletions = true,
    analyses = {
      unusedparams = true,
    },
    staticcheck = true,
    linksInHover = false,
    codelenses = {
      generate = true,
      gc_details = true,
      regenerate_cgo = true,
      tidy = true,
      upgrade_depdendency = true,
      vendor = true,
    },
    usePlaceholders = true,
  },
  lua_ls = {
    Lua = {
      diagnostics = {
        globals = { 'vim', 'jit' },
        neededFileStatus = true,
        ["codestyle-check"] = "Any",
      },

      format = {
        enable = true,
        defaultConfig = {
          indent_style = "space",
          indent_size = "2",
        }
      },

      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
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
