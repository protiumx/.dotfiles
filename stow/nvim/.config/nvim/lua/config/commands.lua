local utils = require('config.utils')
local dev = require('config.dev')

local M = {
  loaded = false,
}

local system_clip_reg = jit.os == 'OSX' and '*' or '+'
local DevWatchGroup = 'DevWatch'

--- Copies the current file GIT URL to system clipboard
local function copy_file_git_url()
  local url = utils.get_git_url(vim.fn.expand('%'))
  vim.fn.setreg(system_clip_reg, url)
  vim.notify(url .. ' copied to clipboard')
end

---@class XCommand
---@field handler fun(...:any)
---@field options string[]

---@type XCommand
local watch_command = {
  handler = function(args)
    ---@type WatchConfig
    local opts = {
      file = vim.fn.expand('%'),
    }
    local cmd_index = -1
    local cmd_start = nil
    for i, param in ipairs(args) do
      local pairs = vim.split(param, '=')
      if pairs[1] == 'cmd' then
        cmd_index = i
        cmd_start = pairs[2]
        break
      end

      opts[pairs[1]] = pairs[2]
    end

    if cmd_index == -1 then
      vim.notify('empty "cmd" option', vim.log.levels.ERROR)
      return
    end
    opts.cmd = { cmd_start }
    for i = cmd_index + 1, #args do
      table.insert(opts.cmd, args[i])
    end

    dev.watch(opts)
  end,
  options = {
    -- 'file',
    'out',
    'cmd',
  },
}

local git_command = {
  handler = copy_file_git_url,
  options = {},
}

local quiet_command = {
  handler = utils.toggle_quiet,
  options = {},
}

---@type table<string, XCommand>
local commands = {
  git_file = git_command,
  toggle_quiet = quiet_command,
  watch = watch_command,
}

-- based off https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/command.lua
local function load_command(cmd, ...)
  local args = { ... }
  local command = commands[cmd]
  command.handler(args)
end

function M.load()
  if M.loaded then
    return
  end

  local subcommands = vim.tbl_keys(commands)
  table.sort(subcommands)

  vim.api.nvim_create_user_command('X', function(args)
    load_command(unpack(args.fargs))
  end, {
    desc = 'X command will help ya',
    nargs = '+',
    complete = function(args, line)
      local l = vim.split(line, '%s+')
      local n = #l - 2

      if n == 1 then
        local command = commands[l[2]]
        if command then
          return vim.tbl_filter(function(val)
            return vim.startswith(val, l[3])
          end, command.options)
        end
      end

      return subcommands
    end,
  })

  M.loaded = true
end

return M
