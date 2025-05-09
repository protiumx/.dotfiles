local mod_cache = nil

---@param fname string
---@return string?
local function get_root(fname)
  if mod_cache and fname:sub(1, #mod_cache) == mod_cache then
    local clients = vim.lsp.get_clients({ name = 'gopls' })
    if #clients > 0 then
      return clients[#clients].config.root_dir
    end
  end
  return vim.fs.root(fname, { 'go.work', 'go.mod', '.git' })
end

local range_format = 'textDocument/rangeFormatting'
local formatting = 'textDocument/formatting'

local get_current_gomod = function()
  local file = io.open('go.mod', 'r')
  if file == nil then
    return nil
  end

  local first_line = file:read()
  local mod_name = first_line:gsub('module ', '')
  file:close()
  return mod_name
end

-- https://github.com/golang/tools/tree/master/gopls
return {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    -- see: https://github.com/neovim/nvim-lspconfig/issues/804
    if mod_cache then
      on_dir(get_root(fname))
      return
    end
    local cmd = { 'go', 'env', 'GOMODCACHE' }
    vim.system(cmd, { text = true }, function(output)
      if output.code == 0 then
        if output.stdout then
          mod_cache = vim.trim(output.stdout)
        end
        on_dir(get_root(fname))
      else
        vim.notify(
          ('[gopls] cmd failed with code %d: %s\n%s'):format(output.code, cmd, output.stderr)
        )
      end
    end)
  end,
  handlers = {
    [range_format] = function(...)
      vim.lsp.handlers[range_format](...)
      if vim.fn.getbufinfo('%')[1].changed == 1 then
        vim.cmd('noautocmd write')
      end
    end,
    [formatting] = function(...)
      vim.lsp.handlers[formatting](...)
      if vim.fn.getbufinfo('%')[1].changed == 1 then
        vim.cmd('noautocmd write')
      end
    end,
  },
  settings = {
    analyses = {
      unusedparams = true,
      unusedvariable = true,
      useany = true,
    },
    codelenses = {
      generate = true,
      gc_details = true,
      regenerate_cgo = true,
      test = true,
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
    linksInHover = true,
    staticcheck = true,
    completeUnimported = true,
    usePlaceholders = true,
    diagnosticsDelay = '1s',
    -- diagnosticsTrigger = 'Edit', -- update diagnostics on update instead of on write
    symbolMatcher = 'FastFuzzy',
    semanticTokens = false,
    vulncheck = 'Imports',
    buildFlags = { '-tags', 'stack' },
    ['local'] = get_current_gomod(),
  },
}
