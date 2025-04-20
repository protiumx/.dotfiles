-- From https://github.com/TheRealLorenz/nvim-lspconfig/blob/master/lua/lspconfig/util.lua
local M = {}

function M.validate_bufnr(bufnr)
  vim.validate('bufnr', bufnr, 'number')
  return bufnr == 0 and vim.api.nvim_get_current_buf() or bufnr
end

function M.search_ancestors(startpath, func)
  vim.validate('func', func, 'function')
  if func(startpath) then
    return startpath
  end
  local guard = 100
  for path in vim.fs.parents(startpath) do
    -- Prevent infinite recursion if our algorithm breaks
    guard = guard - 1
    if guard == 0 then
      return
    end

    if func(path) then
      return path
    end
  end
end

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
  local patterns = vim.iter({ ... }):flatten(math.huge):totable()
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

-- For zipfile: or tarfile: virtual paths, returns the path to the archive.
-- Other paths are returned unaltered.
function M.strip_archive_subpath(path)
  -- Matches regex from zip.vim / tar.vim
  path = vim.fn.substitute(path, 'zipfile://\\(.\\{-}\\)::[^\\\\].*$', '\\1', '')
  path = vim.fn.substitute(path, 'tarfile:\\(.\\{-}\\)::.*$', '\\1', '')
  return path
end

return M
