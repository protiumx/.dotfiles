local M = {}

function M.setup()
  require("nvim-tree").setup({
    hijack_unnamed_buffer_when_opening = false,
    hijack_directories = {
      enable = false,
    },
    hijack_cursor = true,
    renderer = {
      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = false,
          git = false,
          modified = false,
        },
        glyphs = {
          folder = {
            arrow_closed = "",
            arrow_open = "",
            default = "",
            open = "",
            empty = "",
            empty_open = "",
            symlink = "",
            symlink_open = "",
          },
        }
      }
    },
    update_focused_file = {
      enable = true,
      update_root = false,
      ignore_list = {},
    },
  })

  local api = require('nvim-tree.api')
  vim.keymap.set({ 'n', 'v', 'x' }, '<M-T>', api.tree.focus, { silent = true })
end

return M
