local Path = require('plenary.path')

GlobalState = GlobalState or {}
GlobalState.marked_buffers = GlobalState.marked_buffers or {}
GlobalState.marked_files = GlobalState.marked_files or {}

local state = {
  _global = GlobalState,
}

function state.get_buffer(bufnr)
  return GlobalState.marked_buffers[bufnr]
end

function state.get_file(filename)
  return GlobalState.marked_files[filename]
end

function state.toggle_buffer_mark(bufnr)
  if GlobalState.marked_buffers[bufnr] then
    GlobalState.marked_buffers[bufnr] = nil
  else
    GlobalState.marked_buffers[bufnr] = true
  end

  local filename = Path:new(vim.api.nvim_buf_get_name(bufnr)):make_relative(vim.loop.cwd())
  state.toggle_file_mark(filename)

  return GlobalState.marked_buffers[bufnr]
end

function state.toggle_file_mark(filename)
  if GlobalState.marked_files[filename] then
    GlobalState.marked_files[filename] = nil
  else
    print('marked file', filename)
    GlobalState.marked_files[filename] = true
  end

  return GlobalState.marked_files[filename]
end

return state
