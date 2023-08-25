local M = {}

function M.setup()
  local hop = require('hop')
  local directions = require('hop.hint').HintDirection

  hop.setup({})

  vim.keymap.set({ 'n' }, 's', function()
    hop.hint_char2({ direction = directions.AFTER_CURSOR, current_line_only = false })
  end, { remap = true })

  vim.keymap.set({ 'n' }, 'S', function()
    hop.hint_char2({ direction = directions.BEFORE_CURSOR, current_line_only = false })
  end, { remap = true })

  vim.keymap.set({ 'n', 'v', 'i' }, '<M-h>s', function()
    hop.hint_char2({ direction = directions.AFTER_CURSOR, multi_windows = true })
  end, { remap = true })

  vim.keymap.set({ 'n', 'v', 'i' }, '<M-h>w', function()
    hop.hint_words({ direction = directions.AFTER_CURSOR, multi_windows = true })
  end, { remap = true })

  vim.keymap.set({ 'n', 'v', 'i' }, '<M-h>/', function()
    hop.hint_patterns({ direction = directions.AFTER_CURSOR, multi_windows = true })
  end, { remap = true })

  vim.keymap.set('', 'f', function()
    hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
  end, { remap = true })

  vim.keymap.set('', 'F', function()
    hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
  end, { remap = true })

  vim.keymap.set('', 't', function()
    hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
  end, { remap = true })

  vim.keymap.set('', 'T', function()
    hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
  end, { remap = true })
end

return M
