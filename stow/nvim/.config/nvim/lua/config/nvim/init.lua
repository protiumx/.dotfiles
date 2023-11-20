local ffi = require('ffi')

ffi.cdef([[
char *file_under_cursor();
]])

local lib = ffi.load('main')

local M = {}

--- @return string|nil
function M.file_under_cursor()
  local result = lib.file_under_cursor()
  if result == nil then
    return nil
  end

  return ffi.string(result)
end

return M
