local M = {}

function M.setup()
  local fterm = require('FTerm')
  local term_opts = {
    hl = 'NormalFloat',
    border = 'single',
    dimensions = {
      height = 0.3,
      width = 0.2,
      x = 1,
      y = 0,
    },
  }
  fterm.setup(term_opts)

  vim.api.nvim_create_user_command('TermExit', fterm.exit, { bang = true })
  vim.api.nvim_create_user_command('TermToggle', fterm.toggle, { bang = true })
  vim.api.nvim_create_user_command('TermRun', function(opts)
    fterm.run(opts.args)
  end, {
    bang = true,
    nargs = '+',
  })
end

return M
