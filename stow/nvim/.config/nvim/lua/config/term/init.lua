-- from https://github.com/numToStr/FTerm.nvim

local Term = require('config.term.terminal')

local M = {}

-- default term
local t = Term:new()

---Creates a custom terminal
---@param cfg Config
---@return Term
function M:new(cfg)
  return Term:new():setup(cfg)
end

---Opens the default terminal
function M.open()
  t:open()
end

---Closes the default terminal window but preserves the actual terminal session
function M.close()
  t:close()
end

---Exits the terminal session
function M.exit()
  t:close(true)
end

---Toggles the default terminal
function M.toggle()
  t:toggle()
end

---Run a arbitrary command inside the default terminal
---@param cmd Command
function M.run(cmd)
  if not cmd then
    return vim.notify('FTerm: Please provide a command to run', vim.log.levels.ERROR)
  end

  t:run(cmd)
end

---Returns the job id of the terminal if it exists
function M.get_job_id()
  return t.terminal
end

---To create a scratch (use and throw) terminal. Like those good ol' C++ build terminal.
---@param cfg Config
function M.scratch(cfg)
  if not cfg then
    return vim.notify(
      'FTerm: Please provide configuration for scratch terminal',
      vim.log.levels.ERROR
    )
  end

  cfg.auto_close = false

  M:new(cfg):open()
end

function M.setup()
  local cfg = {
    hl = 'NormalFloat',
    border = 'shadow',
    blend = 20,
    dimensions = {
      height = 0.4,
      width = 0.3,
    },
  }

  t:setup(cfg)

  -- e.g. TRun go tests -v %
  vim.api.nvim_create_user_command('TRun', function(opts)
    M.run(opts.args)
  end, {
    bang = true,
    nargs = '+',
  })

  vim.api.nvim_create_user_command('TScratch', function(opts)
    local cmd = opts.args
    if cmd:find('go test') then
      cmd = string.gsub(opts.args, '%%', './' .. vim.fn.expand('%:h')) .. '/...'
    end
    M.scratch(vim.tbl_extend('force', {
      cmd = cmd,
    }, cfg))
  end, {
    bang = true,
    nargs = '+',
    desc = 'Open scratch term with provided command',
  })

  vim.keymap.set({ 'n', 'v', 't' }, '<M-t>', M.toggle, { desc = 'Toggle floating term' })
  vim.keymap.set({ 'n', 'v', 't' }, '<M-[>', M.close, { desc = 'Close floating term' })
end

return M
