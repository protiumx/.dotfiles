local M = {}

function M.setup()
  local textcase = require('textcase')
  textcase.setup({})

  vim.keymap.set('n', 'gau', function() textcase.operator('to_upper_case') end, { silent = true })
  vim.keymap.set('n', 'gal', function() textcase.operator('to_lower_case') end, { silent = true })
  vim.keymap.set('n', 'gas', function() textcase.operator('to_snake_case') end, { silent = true })
  vim.keymap.set('n', 'gad', function() textcase.operator('to_dash_case') end, { silent = true })
  vim.keymap.set('n', 'gan', function() textcase.operator('to_constant_case') end, { silent = true })
  vim.keymap.set('n', 'gad', function() textcase.operator('to_dot_case') end, { silent = true })
  vim.keymap.set('n', 'gaa', function() textcase.operator('to_phrase_case') end, { silent = true })
  vim.keymap.set('n', 'gac', function() textcase.operator('to_camel_case') end, { silent = true })
  vim.keymap.set('n', 'gap', function() textcase.operator('to_pascal_case') end, { silent = true })
  vim.keymap.set('n', 'gat', function() textcase.operator('to_title_case') end, { silent = true })
  vim.keymap.set('n', 'gaf', function() textcase.operator('to_path_case') end, { silent = true })
end

return M
