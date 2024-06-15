local M = {}

function M.config()
  local textcase = require('textcase')
  textcase.setup({})

  require('telescope').load_extension('textcase')

  vim.keymap.set(
    'n',
    'ga.',
    '<cmd>Telescope textcase normal_mode_quick_change theme=dropdown<CR>',
    { desc = 'Show text case options' }
  )

  vim.keymap.set('n', 'gau', function()
    textcase.operator('to_upper_case')
  end, { silent = true })
  vim.keymap.set('n', 'gal', function()
    textcase.operator('to_lower_case')
  end, { silent = true })
  vim.keymap.set('n', 'gas', function()
    textcase.operator('to_snake_case')
  end, { silent = true })
  vim.keymap.set('n', 'gad', function()
    textcase.operator('to_dash_case')
  end, { silent = true })
  vim.keymap.set('n', 'gan', function()
    textcase.operator('to_constant_case')
  end, { silent = true })
  vim.keymap.set('n', 'gaD', function()
    textcase.operator('to_dot_case')
  end, { silent = true })
  vim.keymap.set('n', 'gac', function()
    textcase.operator('to_camel_case')
  end, { silent = true })
  vim.keymap.set('n', 'gap', function()
    textcase.operator('to_pascal_case')
  end, { silent = true })
end

return M
