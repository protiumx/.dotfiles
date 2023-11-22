local M = {}
local system_clip_reg = jit.os == 'OSX' and '*' or '+'

---@class DevBuffer
---@field source_buffer number
---@field output_buffer number
---@field autocmd_group string

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

---@param cmd string
---@param bufnr number
local function print_cmd_output(cmd, bufnr)
  vim.fn.jobstart(vim.split(cmd, ' '), {
    stdout_bufered = true,
    on_stdout = function(_, content)
      if content then
        vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, content)
      end
    end,
    on_stderr = function(_, content)
      if content then
        vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, content)
      end
    end,
  })
end

---@param source_buffer number
local function tear_down_dev_buffer(source_buffer)
  local dev_buffer = dev_buffers[source_buffer]

  vim.cmd('autocmd! ' .. dev_buffer.autocmd_group)
  dev_buffers[source_buffer] = nil

  vim.notify('[dev] stopped', vim.log.levels.INFO)
end

--- Setup dev mode for the current buffer
---@param args string[]
local function setup_dev_buffer(args)
  local buffer = vim.api.nvim_get_current_buf()
  local bufname = vim.fn.bufname(buffer)

  local dev_buf = dev_buffers[buffer] --[[@as DevBuffer]]
  if dev_buf then
    vim.notify('[dev] already enabled: ' .. bufname, vim.log.levels.INFO)
    return
  end

  local cmd = table.concat(args, ' '):gsub('%%', vim.fn.expand('%'))
  local output_buffer = vim.api.nvim_create_buf(true, true)
  vim.api.nvim_buf_set_name(output_buffer, 'dev[' .. bufname .. ']')
  -- vim.api.nvim_buf_set_option(output_buffer, 'readonly', true)

  vim.cmd.split({ mods = { vertical = true } })
  vim.api.nvim_win_set_buf(vim.api.nvim_get_current_win(), output_buffer)
  vim.cmd('wincmd w')

  local autocmd_group = string.format('DevWatch-%d', buffer)
  dev_buffers[buffer] = {
    source_buffer = buffer,
    output_buffer = output_buffer,
    autocmd_group = autocmd_group,
  }

  local function header()
    vim.api.nvim_buf_set_lines(output_buffer, 0, -1, false, { '[dev] - ' .. cmd, '' })
  end

  vim.api.nvim_create_autocmd('BufWritePost', {
    group = vim.api.nvim_create_augroup(autocmd_group, { clear = true }),
    buffer = buffer,
    callback = function()
      header()
      print_cmd_output(cmd, output_buffer)
    end,
  })

  vim.api.nvim_create_autocmd('BufUnload', {
    group = vim.api.nvim_create_augroup('dev_teardown', { clear = true }),
    buffer = output_buffer,
    callback = function()
      tear_down_dev_buffer(buffer)
    end,
  })

  vim.notify('[dev] enabled: ' .. bufname, vim.log.levels.INFO)

  header()
  print_cmd_output(cmd, output_buffer)
end

local commands = {
  git_file = copy_current_git_file,
  dev = setup_dev_buffer,
  date = nil,
}

local function load_command(cmd, ...)
  local args = { ... }
  if next(args) ~= nil then
    (commands[cmd] --[[@as fun(args:any[])]])(args)
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
