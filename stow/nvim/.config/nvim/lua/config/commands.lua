local M = {}

local commands = {
  git_file = function()
    local remote = vim.fn.system('gremote')
    local branch = vim.fn.system('git rev-parse --abbrev-ref HEAD')
    print(string.format('%s/tree/%s/%s', remote, branch, vim.fn.expand('%')):gsub('[\n\r]', ''))
  end
}

local function load_command(cmd, ...)
  local args = { ... }
  if next(args) ~= nil then
    commands[cmd](args[1])
  else
    commands[cmd]()
  end
end


function M.load()
  vim.api.nvim_create_user_command('X', function(args)
    load_command(unpack(args.fargs))
  end, {
    desc = 'X command will help ya',
    nargs = '+',
    complete = function(arg)
      local list = vim.tbl_keys(commands)
      return vim.tbl_filter(function(s)
        return string.match(s, '^' .. arg)
      end, list)
    end,
  })
end

return M
