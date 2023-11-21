local Path = require('plenary.path')
local nvim = require('config.nvim')

local M = {}

function M.get_vsel()
  local vstart = vim.fn.getpos("'<")
  local vend = vim.fn.getpos("'>")

  local line_start = vstart[2]
  local line_end = vend[2]

  local lines = vim.fn.getline(line_start, line_end)
  return lines and lines[0] or ''
end

--- Get text from visual selection
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

--- Open the file under cursor in existing window if available, else open a new vsplit
function M.open_file_under_cursor()
  local file = nvim.file_under_cursor()
  if file == nil then
    return
  end

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

--- Find buffer by name relative to cwd
function M.find_buffer_by_name(name)
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    local buf_name = vim.api.nvim_buf_get_name(buf)
    buf_name = Path:new(buf_name):make_relative(vim.loop.cwd())
    if buf_name == name then
      return buf
    end
  end
  return -1
end

--- Uses `errorformat` to get a file and position from the current line
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

return M
