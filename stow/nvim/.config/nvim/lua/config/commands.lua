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
    local opts = {}
    local cmd_index = -1
    local cmd_start = nil
    for i, param in ipairs(args) do
      local pairs = vim.split(param, '=')
      if #pairs == 1 then
        -- bool option
        opts[pairs[1]] = true
      elseif pairs[1] == 'cmd' then
        cmd_index = i
        cmd_start = pairs[2]
        break
      else
        opts[pairs[1]] = pairs[2]
      end
    end

    if opts.inspect then
      dev.inspect()
      return
    end

    if cmd_index == -1 then
      vim.notify('empty "cmd" option', vim.log.levels.ERROR)
      return
    end

    opts.cmd = { cmd_start }
    -- Take the rest of the line
    for i = cmd_index + 1, #args do
      table.insert(opts.cmd, args[i])
    end

    dev.watch(opts)
  end,
  options = {
    'cmd',
    'cwd',
    'inspect',
    'out',
    'pattern',
  },
}

local git_command = {
  handler = function(args)
    if vim.tbl_contains(args, 'url') then
      copy_file_git_url()
    end
  end,
  options = {
    'url',
  },
}

local quiet_command = {
  handler = utils.toggle_quiet,
  options = {},
}

---@type table<string, XCommand>
local commands = {
  git = git_command,
  quiet = quiet_command,
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

  local commands_ids = vim.tbl_keys(commands)
  table.sort(commands_ids)

  vim.api.nvim_create_user_command('X', function(args)
    load_command(unpack(args.fargs))
  end, {
    desc = 'X command will help ya',
    bang = false,
    bar = false,
    range = false,
    nargs = '+',
    ---@param args any
    ---@param line string
    complete = function(args, line)
      local parts = vim.split(line, '%s+')
      local n = #parts - 2

      local candidates = {}
      local position = 2

      if n >= 1 then
        local command = commands[parts[2]]
        if command then
          candidates = command.options
          position = n + 2
        end
      end

      candidates = vim.tbl_filter(function(val)
        return not line:find(val) and vim.startswith(val, parts[position])
      end, candidates)

      if #candidates > 0 then
        return candidates
      end

      return commands_ids
    end,
  })

  M.loaded = true
end

return M
