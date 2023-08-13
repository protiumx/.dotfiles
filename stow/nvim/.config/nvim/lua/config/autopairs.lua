local M = {}

function M.setup()
  -- local cmp = require('cmp')
  -- local cmp_autopairs = require('nvim-autopairs.completion.cmp')

  require('nvim-autopairs').setup({
    fast_wrap = {},
    disable_filetype = { 'TelescopePrompt', 'vim' },
    check_ts = true,
  })

  -- -- Add parens to functions
  -- cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
end

return M
