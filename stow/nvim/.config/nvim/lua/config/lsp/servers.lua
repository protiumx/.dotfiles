local servers = {
  dockerls = {},
  -- graphql = {},
  tsserver = {},
  html = {},
  jsonls = {
    schemas = require('schemastore').json.schemas(),
  },
  eslint = {},
  marksman = {},
  rust_analyzer = {
    ['rust-analyzer'] = {
      assist = {
        importEnforceGranularity = true,
        importPrefix = 'create',
      },
      cargo = {
        allFeatures = true,
        loadOutDirsFromCheck = true,
        runBuildScripts = true,
      },
      -- Add clippy lints for Rust.
      checkOnSave = {
        allFeatures = true,
        command = 'clippy',
        extraArgs = { '--no-deps' },
      },
      inlay_hints = {
        auto = false,
      },
      procMacro = {
        enable = true,
        ignored = {
          ['async-trait'] = { 'async_trait' },
          ['napi-derive'] = { 'napi' },
          ['async-recursion'] = { 'async_recursion' },
        },
      },
    },
  },
  clangd = {
    cmd = {
      'clangd',
      '-j=6',
      '--all-scopes-completion',
      '--background-index', -- should include a compile_commands.json or .txt
      '--clang-tidy',
      '--cross-file-rename',
      '--completion-style=detailed',
      '--fallback-style=Microsoft',
      '--function-arg-placeholders',
      '--header-insertion-decorators',
      '--header-insertion=never',
      '--limit-results=10',
      '--pch-storage=memory',
      '--query-driver=/usr/include/*',
      '--suggest-missing-includes',
    },
  },
  pyright = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = 'workspace',
        useLibraryCodeForTypes = true,
      },
    },
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
        url = 'https://www.schemastore.org/api/json/catalog.json',
      },
      schemas = require('schemastore').yaml.schemas(),
      validate = true,
    },
  },
  bashls = {
    filetypes = { 'sh', 'zsh' },
  },
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
    hints = {
      assignVariableTypes = true,
      compositeLiteralFields = true,
      compositeLiteralTypes = true,
      constantValues = true,
      functionTypeParameters = true,
      parameterNames = true,
      rangeVariableTypes = true,
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
        },
      },
      hint = {
        enable = true,
      },
      runtime = {
        version = 'LuaJIT',
      },
      workspace = {
        checkThirdParty = false,
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
        maxPreload = 10000,
        preloadFileSize = 10000,
      },
      telemetry = { enable = false },
    },
  },
}

if jit.os ~= 'OSX' then
  servers.ocamllsp = {
    codelens = { enable = true },
  }
end

return servers
