local M = {}

function M.setup()
  local fterm = require('FTerm')

  vim.api.nvim_create_user_command('Scratch', function(opts)
    fterm.scratch({
      cmd = opts.args,
      border = 'none',
      dimensions = {
        height = 0.2,
        width = 0.3,
        x = 1,
        y = 0,
      },
    })
  end, {
    bang = true,
    nargs = '+',
  })
end

return M
