return {
  'machakann/vim-sandwich',
  event = 'BufRead',
  init = function()
    vim.g.sandwich_no_default_key_mappings = true
  end,
  config = function()
    vim.cmd([[
      call operator#sandwich#set('all', 'all', 'highlight', 1)
    ]])
  end,
  keys = {
    { '<M-s>a', '<Plug>(sandwich-add)', remap = true },
    { 'sa', '<Plug>(sandwich-add)', mode = { 'x', 'o', 'v' }, remap = true },

    { '<M-s>d', '<Plug>(sandwich-delete)', remap = true },
    { 'sd', '<Plug>(sandwich-delete)', mode = { 'x', 'o', 'v' }, remap = true },

    { '<M-s>r', '<Plug>(sandwich-replace-auto)', remap = true },
    { 'sr', '<Plug>(sandwich-replace)', mode = { 'x', 'o', 'v' }, remap = true },

    { 'is', '<Plug>(textobj-sandwich-query-i)', mode = 'x', remap = true },
    { 'as', '<Plug>(textobj-sandwich-query-a)', mode = 'x', remap = true },
    { 'is', '<Plug>(textobj-sandwich-query-i)', mode = 'o', remap = true },
    { 'as', '<Plug>(textobj-sandwich-query-a)', mode = 'o', remap = true },

    -- ext objects e.g. via to select inner text with auto detection of surrounds
    { 'ia', '<Plug>(textobj-sandwich-auto-i)', mode = 'x', remap = true },
    { 'aa', '<Plug>(textobj-sandwich-auto-a)', mode = 'x', remap = true },
    { 'ia', '<Plug>(textobj-sandwich-auto-i)', mode = 'o', remap = true },
    { 'aa', '<Plug>(textobj-sandwich-auto-a)', mode = 'o', remap = true },
    -- surrounds e.g. cim_ deletes text surrounded by _
    { 'im', '<Plug>(textobj-sandwich-literal-query-i)', mode = 'x', remap = true },
    { 'im', '<Plug>(textobj-sandwich-literal-query-i)', mode = 'o', remap = true },
    { 'am', '<Plug>(textobj-sandwich-literal-query-a)', mode = 'x', remap = true },
    { 'am', '<Plug>(textobj-sandwich-literal-query-a)', mode = 'o', remap = true },
  },
}
