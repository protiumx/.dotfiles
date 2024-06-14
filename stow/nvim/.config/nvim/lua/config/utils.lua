-- local nvim = require('config.nvim')
local state = require('config.state')

local M = {}

---Returns the current cwd folder name
function M.get_cwd_name()
  return vim.fn.fnamemodify(vim.loop.cwd(), ':t')
end

---@param original table
---@return table
function M.tbl_clone(original)
  local copy = {}
  for key, value in pairs(original) do
    copy[key] = value
  end
  return copy
end

---Get text from visual selection
function M.get_selection_text()
  local a_orig = vim.fn.getreg('a')
  local mode = vim.fn.mode()
  if mode ~= 'v' and mode ~= 'V' then
    vim.cmd([[normal! gv]])
  end

  vim.cmd([[normal! "aygv]])
  local text = vim.fn.getreg('a')
  vim.fn.setreg('a', a_orig)
  return text
end

---Open the file under cursor in existing window if available, else open a new vsplit
function M.open_file_under_cursor()
  local file = vim.fn.expand('<cfile>')
  local parts = vim.split(file, ':')
  local pos_cmd = string.format('call cursor(%s, %s)', parts[2], #parts == 3 and parts[3] or '0')

  -- local bufnr = vim.fn.bufnr(parts[1])
  -- local winids = vim.fn.win_findbuf(bufnr)
  -- if #winids == 0 then
  --   vim.cmd(string.format('vs %s | %s', parts[1], pos_cmd))
  --   return
  -- end
  local cmd = string.format('drop %s | %s', parts[1], pos_cmd)
  vim.cmd(cmd)
end

---Uses `errorformat` to get a file and position from the current line
function M.open_file_from_error()
  local elems = vim.fn.getqflist({
    efm = vim.o.errorformat,
    lines = { vim.api.nvim_get_current_line() },
  }).items

  if #elems < 1 then
    return
  end
  local fname = vim.fn.bufname(elems[1].bufnr)
  if not fname then
    vim.notify('No buffer found', vim.log.levels.ERROR)
    return
  end

  vim.cmd(string.format('drop %s | call cursor(%s, %s)', fname, elems[1].lnum, elems[1].col))
end

---Toggle LSP and global state 'quiet' value
function M.toggle_quiet()
  if state.get('quiet') then
    vim.cmd([[
      LspStart
      set spell
    ]])
    state.set('quiet', false)
    vim.notify('Back to full power', vim.log.levels.INFO)
  else
    vim.cmd([[
      LspStop
      set nospell
    ]])
    state.set('quiet', true)
    vim.notify('Quiet mode', vim.log.levels.INFO)
  end
end

---@param filename string
---@return string|nil
function M.get_git_url(filename)
  local remote_output = vim.fn.systemlist('gremote')
  if #remote_output == 0 then
    vim.notify('No remote found in current cwd', vim.log.levels.WARN)
    return nil
  end

  local branch_output = vim.fn.systemlist('git rev-parse --abbrev-ref HEAD')

  local remote = remote_output[1]
  local branch = branch_output[1]

  local url = string.format('%s/tree/%s/%s', remote, branch, filename)
  if string.find(remote, 'bitbucket') then
    url = string.format('%s/browse/%s?at=refs/heads/%s', remote, filename, branch)
  end

  return url
end

function M.uuid()
  local id, _ = vim.fn.system('uuidgen'):gsub('\n', ''):lower()
  return id
end

function M.uid()
  local uuid = M.uuid()
  return string.gsub(uuid, '-', '')
end

return M
