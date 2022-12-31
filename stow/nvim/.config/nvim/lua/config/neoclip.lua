local M = {}

function M.setup()
  require('neoclip').setup({
    history = 20,
    enable_persistent_history = false,
    length_limit = 1000,
    preview = true,
    prompt = nil,
    default_register = '"',
    default_register_macros = 'q',
    enable_macro_history = true,
    content_spec_column = false,
    on_paste = {
      set_reg = false,
    },
    on_replay = {
      set_reg = false,
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
