local M = {}

function M.setup()
  local fterm = require('FTerm')
  local term_opts = {
    hl = 'NormalFloat',
    border = 'single',
    dimensions = {
      height = 0.4,
      width = 0.3,
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

  vim.api.nvim_create_user_command('TermScratch', function(opts)
    local cmd = opts.args
    if cmd:find('go test') then
      cmd = string.gsub(opts.args, '%%', './' .. vim.fn.expand('%:h')) .. '/...'
    end
    fterm.scratch(vim.tbl_extend('force', {
      cmd = cmd,
    }, term_opts))
  end, {
    bang = true,
    nargs = '+',
    desc = 'Open scratch term with provided command'
  })

  vim.keymap.set({ 'n', 'v', 't' }, '<M-t>', fterm.toggle, { desc = 'Toggle floating term' })
end

return M
