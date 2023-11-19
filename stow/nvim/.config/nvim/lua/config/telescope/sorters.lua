local sorters = require('telescope.sorters')
local state = require('config.state')

local M = {}

function M.buffer_sorter()
  local sorter = sorters.get_fzy_sorter()
  sorter.internal = sorter.scoring_function
  sorter.scoring_function = function(s, prompt, line, entry)
    if state.get_buffer(entry.bufnr) then
      return 1e-5
    end
    return sorter.internal(s, prompt, line, entry)
  end

  return sorter
end

function M.file_sorter()
  local sorter = sorters.get_fzy_sorter()
  sorter.internal = sorter.scoring_function
  local p = false
  sorter.scoring_function = function(s, prompt, line, entry)
    if not p then
      print('entry sample', vim.inspect(entry))
      p = true
    end
    if state.get_file(entry.filename) then
      return 1e-5
    end
    return sorter.internal(s, prompt, line, entry)
  end

  return sorter
end

return M
