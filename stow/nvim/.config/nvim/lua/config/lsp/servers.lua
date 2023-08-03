local servers = {
  dockerls = {},
  graphql = {},
  tsserver = {},
  html = {},
  jsonls = {
    schemas = require("schemastore").json.schemas(),
  },
  eslint = {},
  rust_analyzer = {
    ["rust-analyzer"] = {
      assist = {
        importEnforceGranularity = true,
        importPrefix = "create"
      },
      cargo = { allFeatures = true },
      checkOnSave = {
        command = "clippy",
        allFeatures = true
      }
    },
  },
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
  sqlls = {},
  yamlls = {
    yaml = {
      completion = true,
      format = {
        enable = true,
        proseWrap = 'never',
        printWidth = 200,
      },
      keyOrdering = false,
      schemaStore = {
        enable = true,
        url = "https://www.schemastore.org/api/json/catalog.json",
      },
      schemas = require("schemastore").yaml.schemas(),
      validate = true,
    },
  },
  terraformls = {},
  bashls = {},
  gopls = {
    analyses = {
      unusedparams = true,
      unusedvariable = true,
      useany = true,
    },
    codelenses = {
      generate = true,
      gc_details = true,
      regenerate_cgo = true,
      tidy = true,
      upgrade_depdendency = true,
      vendor = true,
    },
    experimentalPostfixCompletions = true,
    gofumpt = true,
    linksInHover = false,
    staticcheck = true,
    usePlaceholders = true,
  },
  lua_ls = {
    Lua = {
      diagnostics = {
        globals = { 'vim', 'jit' },
        neededFileStatus = true,
        ['codestyle-check'] = 'Any',
      },
      format = {
        enable = true,
        defaultConfig = {
          indent_style = 'space',
          indent_size = '2',
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
