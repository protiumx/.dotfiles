local M = {}

local commands = {
  toggle_format_on_save = function()
    require('config.state')
  end
}

function M.load()
  vim.api.nvim_create_user_command('Config', function(args)
    require('lspsaga.command').load_command(unpack(args.fargs))
  end, { desc = 'Toggle format on save' })
end

return M
