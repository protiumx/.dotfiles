local Popup = require('nui.popup')
local event = require('nui.utils.autocmd').event

-- Global for all plugins and internal views
local M = {
  winblend = 15,
}

local nui_popup_base = {
  enter = true,
  focusable = true,
  position = '50%',
  size = {
    width = '40%',
    height = '60%',
  },
  relative = 'editor',
  border = {
    padding = {
      top = 1,
      bottom = 1,
      left = 1,
      right = 1,
    },
    style = 'none',
  },
  buf_options = {
    modifiable = true,
    readonly = false,
  },
  win_options = {
    winblend = M.winblend,
    winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder',
  },
}

---@param opts table|nil
function M.popup(opts)
  local popup = Popup(vim.tbl_extend('force', nui_popup_base, opts or {}))

  popup:map('n', 'q', function()
    popup:hide()
  end)

  popup:on(event.BufLeave, function()
    popup:hide()
  end)

  return popup
end

return M
