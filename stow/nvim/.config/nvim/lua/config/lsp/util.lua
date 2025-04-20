-- From https://github.com/TheRealLorenz/nvim-lspconfig/blob/master/lua/lspconfig/util.lua
local M = {}

function M.bufname_valid(bufname)
  if
    bufname:match('^/')
    or bufname:match('^[a-zA-Z]:')
    or bufname:match('^zipfile://')
    or bufname:match('^tarfile:')
  then
    return true
  end
  return false
end

local function escape_wildcards(path)
  return path:gsub('([%[%]%?%*])', '\\%1')
end

function M.root_pattern(...)
  local patterns = M.tbl_flatten({ ... })
  return function(startpath)
    startpath = M.strip_archive_subpath(startpath)
    for _, pattern in ipairs(patterns) do
      local match = M.search_ancestors(startpath, function(path)
        for _, p in
          ipairs(vim.fn.glob(table.concat({ escape_wildcards(path), pattern }, '/'), true, true))
        do
          if vim.uv.fs_stat(p) then
            return path
          end
        end
      end)

      if match ~= nil then
        return match
      end
    end
  end
end

function M.insert_package_json(config_files, field, fname)
  local path = vim.fn.fnamemodify(fname, ':h')
  local root_with_package =
    vim.fs.dirname(vim.fs.find('package.json', { path = path, upward = true })[1])

  if root_with_package then
    -- only add package.json if it contains field parameter
    local path_sep = iswin and '\\' or '/'
    for line in io.lines(root_with_package .. path_sep .. 'package.json') do
      if line:find(field) then
        config_files[#config_files + 1] = 'package.json'
        break
      end
    end
  end
  return config_files
end

function M.get_config_by_ft(filetype)
  local configs = require('lspconfig.configs')
  local matching_configs = {}
  for _, config in pairs(configs) do
    local filetypes = config.filetypes or {}
    for _, ft in pairs(filetypes) do
      if ft == filetype then
        table.insert(matching_configs, config)
      end
    end
  end
  return matching_configs
end

--- Note: In Nvim 0.11+ this currently has no public interface, the healthcheck uses the private
--- `vim.lsp._enabled_configs`:
--- https://github.com/neovim/neovim/blob/28e819018520a2300eaeeec6794ffcd614b25dd2/runtime/lua/vim/lsp/health.lua#L186
function M.get_managed_clients()
  local configs = require('lspconfig.configs')
  local clients = {}
  for _, config in pairs(configs) do
    if config.manager then
      vim.list_extend(clients, config.manager:clients())
    end
  end
  return clients
end

-- For zipfile: or tarfile: virtual paths, returns the path to the archive.
-- Other paths are returned unaltered.
function M.strip_archive_subpath(path)
  -- Matches regex from zip.vim / tar.vim
  path = vim.fn.substitute(path, 'zipfile://\\(.\\{-}\\)::[^\\\\].*$', '\\1', '')
  path = vim.fn.substitute(path, 'tarfile:\\(.\\{-}\\)::.*$', '\\1', '')
  return path
end

return M
