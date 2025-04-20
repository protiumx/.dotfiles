-- https://clangd.llvm.org/extensions.html#switch-between-sourceheader
local function switch_source_header(bufnr)
  local method_name = 'textDocument/switchSourceHeader'
  bufnr = vim.validate('bufnr', bufnr, 'number')
  local client = vim.lsp.get_clients({ bufnr = bufnr, name = 'clangd' })[1]
  if not client then
    return vim.notify(
      ('method %s is not supported by any servers active on the current buffer'):format(method_name)
    )
  end
  local params = vim.lsp.util.make_text_document_params(bufnr)
  client.request(method_name, params, function(err, result)
    if err then
      error(tostring(err))
    end
    if not result then
      vim.notify('corresponding file cannot be determined')
      return
    end
    vim.cmd.edit(vim.uri_to_fname(result))
  end, bufnr)
end

local function symbol_info()
  local bufnr = vim.api.nvim_get_current_buf()
  local clangd_client = vim.lsp.get_clients({ bufnr = bufnr, name = 'clangd' })[1]
  if not clangd_client or not clangd_client.supports_method('textDocument/symbolInfo') then
    return vim.notify('Clangd client not found', vim.log.levels.ERROR)
  end
  local win = vim.api.nvim_get_current_win()
  local params = vim.lsp.util.make_position_params(win, clangd_client.offset_encoding)
  clangd_client.request('textDocument/symbolInfo', params, function(err, res)
    if err or #res == 0 then
      -- Clangd always returns an error, there is not reason to parse it
      return
    end
    local container = string.format('container: %s', res[1].containerName) ---@type string
    local name = string.format('name: %s', res[1].name) ---@type string
    vim.lsp.util.open_floating_preview({ name, container }, '', {
      height = 2,
      width = math.max(string.len(name), string.len(container)),
      focusable = false,
      focus = false,
      border = 'single',
      title = 'Symbol Info',
    })
  end, bufnr)
end

-- https://clangd.llvm.org/installation.html
return {
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
  filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
  root_markers = {
    '.clangd',
    '.clang-tidy',
    '.clang-format',
    'compile_commands.json',
    'compile_flags.txt',
    'configure.ac', -- AutoTools
    '.git',
  },
  capabilities = {
    textDocument = {
      completion = {
        editsNearCursor = true,
      },
    },
    offsetEncoding = { 'utf-8', 'utf-16' },
  },
  on_attach = function()
    vim.api.nvim_buf_create_user_command(0, 'ClangdSwitchSourceHeader', function()
      switch_source_header(0)
    end, { desc = 'Switch between source/header' })

    vim.api.nvim_buf_create_user_command(0, 'ClangdShowSymbolInfo', function()
      symbol_info()
    end, { desc = 'Show symbol info' })
  end,
}
