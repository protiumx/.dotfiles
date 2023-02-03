local M = {}

function M.setup()
  local function is_whitespace(line)
    return vim.fn.match(line, [[^\s*$]]) ~= -1
  end

  local function all(tbl, check)
    for _, entry in ipairs(tbl) do
      if not check(entry) then
        return false
      end
    end
    return true
  end

  require('neoclip').setup({
    history = 100,
    enable_persistent_history = false,
    length_limit = 1000,
    preview = true,
    prompt = nil,
    default_register = '"',
    default_register_macros = 'q',
    enable_macro_history = true,
    content_spec_column = false,
    filter = function(data)
      return not all(data.event.regcontents, is_whitespace)
    end,
    on_paste = {
      set_reg = true,
      move_to_front = true,
    },
    on_replay = {
      set_reg = true,
      move_to_front = true,
    },
    keys = {
      telescope = {
        i = {
          select = '<CR>',
          paste = '<C-p>',
          paste_behind = '<C-k>',
          replay = '<C-q>', -- replay a macro
          delete = '<C-d>', -- delete an entry
        },
        n = {
          select = '<CR>',
          paste = 'p',
          paste_behind = 'P',
          replay = 'q',
          delete = 'd',
        },
      },
    },
  })
end

return M
