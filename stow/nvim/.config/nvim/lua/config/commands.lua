local utils = require('config.utils')

local M = {
  loaded = false,
}

local system_clip_reg = jit.os == 'OSX' and '*' or '+'
local DevWatchGroup = 'DevWatch'

---@class DevBuffer
---@field source_buffer number
---@field output_buffer number

---@type table<number, DevBuffer>
local dev_buffers = {}

--- Copies the current file VCS URL to system clipboard
local function copy_current_git_file()
  local remote = vim.fn.systemlist('gremote')
  if not remote then
    vim.notify('no remote found', vim.log.levels.WARN)
    return
  end

  remote = remote[1]
  local branch = vim.fn.systemlist('git rev-parse --abbrev-ref HEAD')
  branch = branch[1]

  local file = vim.fn.expand('%')
  local url = string.format('%s/tree/%s/%s', remote, branch, file)
  if string.find(remote, 'bitbucket') then
    url = string.format('%s/browse/%s?at=refs/heads/%s', remote, file, branch)
  end

  vim.fn.setreg(system_clip_reg, url)
  print(url .. ' copied to clipboard')
end

local function set_buffer_text(buffer, content)
  if content then
    vim.api.nvim_buf_set_lines(buffer, -1, -1, false, content)
  end
end

---@param cmd string
---@param bufnr number
local function print_cmd_output(cmd, bufnr)
  vim.fn.jobstart(vim.split(cmd, ' '), {
    stdout_bufered = true,
    on_stdout = function(_, content)
      set_buffer_text(bufnr, content)
    end,
    on_stderr = function(_, content)
      set_buffer_text(bufnr, content)
    end,
  })
end

---@param buffer number
local function delete_buffer(buffer)
  if vim.api.nvim_buf_is_valid(buffer) and vim.api.nvim_buf_is_loaded(buffer) then
    local ok = pcall(vim.api.nvim_buf_delete, buffer, { force = true })
    if not ok then
      vim.notify('[dev] failed to delete output buffer', vim.log.levels.WARN)
    end
  end
end

---@param source_buffer number
local function tear_down_dev_buffer(source_buffer)
  local dev_buffer = dev_buffers[source_buffer]

  if not dev_buffer then
    return
  end

  vim.api.nvim_clear_autocmds({
    group = DevWatchGroup,
    event = 'BufWritePost',
    buffer = dev_buffer.source_buffer,
  })

  dev_buffers[source_buffer] = nil
  vim.notify('[dev] terminated', vim.log.levels.INFO)
end

---@param args string[]
local function _setup_dev_buffer(args)
  local buffer = vim.api.nvim_get_current_buf()
  local bufname = vim.fn.bufname(buffer)

  local dev_buf = dev_buffers[buffer] --[[@as DevBuffer]]
  if dev_buf then
    vim.notify('[dev] already started: ' .. bufname, vim.log.levels.INFO)
    return
  end

  local cmd = table.concat(args, ' '):gsub('%%', vim.fn.expand('%'))
  local title = '[dev] - ' .. cmd
  local output_buffer = vim.api.nvim_create_buf(true, true)
  pcall(vim.api.nvim_buf_set_option, output_buffer, 'filetype', DevWatchGroup)

  vim.cmd.split({ mods = { vertical = true } })
  local winid = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_hl_ns(winid, M.namespace_id)
  vim.api.nvim_win_set_option(winid, 'number', false)
  vim.api.nvim_win_set_option(winid, 'relativenumber', false)
  vim.api.nvim_win_set_option(winid, 'spell', false)
  vim.api.nvim_win_set_buf(winid, output_buffer)
  vim.api.nvim_buf_set_name(output_buffer, 'dev[' .. bufname .. ']')
  vim.api.nvim_buf_set_keymap(output_buffer, 'n', 'q', '<cmd>q<CR>', { silent = true })

  vim.cmd([[
    wincmd w
  ]])

  dev_buffers[buffer] = {
    source_buffer = buffer,
    output_buffer = output_buffer,
  }

  local function header()
    vim.api.nvim_buf_set_lines(output_buffer, 0, -1, false, { title, '' })
    vim.api.nvim_buf_set_extmark(
      output_buffer,
      M.namespace_id,
      0,
      0,
      { end_row = 1, hl_group = 'TelescopePromptTitle', hl_eol = true }
    )
  end

  vim.api.nvim_create_autocmd('BufWritePost', {
    group = DevWatchGroup,
    buffer = buffer,
    callback = function()
      header()
      print_cmd_output(cmd, output_buffer)
    end,
  })

  vim.api.nvim_create_autocmd('BufDelete', {
    group = DevWatchGroup,
    buffer = buffer,
    once = true,
    nested = true,
    callback = function()
      dev_buffers[buffer] = nil
      delete_buffer(output_buffer)
    end,
  })

  vim.api.nvim_create_autocmd('BufUnload', {
    group = vim.api.nvim_create_augroup('dev_teardown', { clear = true }),
    buffer = output_buffer,
    once = true,
    nested = true,
    callback = function()
      tear_down_dev_buffer(buffer)
    end,
  })

  vim.notify('[dev] started: ' .. bufname, vim.log.levels.INFO)

  header()
  print_cmd_output(cmd, output_buffer)
end

--- Setup dev mode for the current buffer
---@param args string[]
local function setup_dev_buffer(args)
  if args == nil or #args == 0 then
    vim.notify('No argument given', vim.log.levels.ERROR)
    return
  end

  vim.schedule(function()
    _setup_dev_buffer(args)
  end)
end

local commands = {
  date = nil,
  dev = setup_dev_buffer,
  git_file = copy_current_git_file,
  toggle_quiet = utils.toggle_quiet,
}

-- based off https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/command.lua
local function load_command(cmd, ...)
  local args = { ... }
  -- local opts = {}

  -- for _, arg in ipairs(args) do
  --   if arg:find('=', 1) == nil then
  --     user_opts['extension_type'] = arg
  --   else
  --     local param = vim.split(arg, '=')
  --     local key = table.remove(param, 1)
  --     param = table.concat(param, '=')
  --     opts.opts[key] = param
  --   end
  -- end

  if next(args) ~= nil then
    (commands[cmd] --[[@as fun(args:any[])]])(args)
  else
    commands[cmd]()
  end
end

function M.load()
  if M.loaded then
    return
  end

  M.namespace_id = vim.api.nvim_create_namespace('XSpace')
  vim.api.nvim_create_augroup(DevWatchGroup, { clear = true })

  vim.api.nvim_create_user_command('X', function(args)
    load_command(unpack(args.fargs))
  end, {
    desc = 'X command will help ya',
    nargs = '+',
    complete = function(args, line)
      print('fash', args, line)
      local l = vim.split(line, '%s+')
      local n = #l - 2

      if n == 1 then
        print('asdfasdfsdf')
        local list = vim.tbl_keys(commands)
        table.sort(list)

        return vim.tbl_filter(function(val)
          return vim.startswith(val, l[2])
        end, commands)
      end

      -- local options_list = vim.tbl_keys(require('telescope.config').values)
      -- table.sort(options_list)

      -- return vim.tbl_filter(function(val)
      --   return vim.startswith(val, l[#l])
      -- end, options_list)
      local list = vim.tbl_keys(commands)
      table.sort(list)
      return list
    end,
  })

  M.loaded = true
end

return M
