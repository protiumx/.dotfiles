local M = {}

local prefix = '[dev] '
---@param msg string
function M.info(msg)
  vim.notify(prefix .. msg, vim.log.levels.INFO)
end

---@param msg string
function M.warn(msg)
  vim.notify(prefix .. msg, vim.log.levels.WARN)
end

---@param msg string
function M.error(msg)
  vim.notify(prefix .. msg, vim.log.levels.ERROR)
end

return M
