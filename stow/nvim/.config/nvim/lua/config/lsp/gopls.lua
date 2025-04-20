-- Adapted from https://github.com/ray-x/go.nvim

local function is_test_file()
  local file = vim.fn.expand('%')
  local is_test = string.find(file, '_test%.go$')
  local is_source = string.find(file, '%.go$')
  return file, (not is_test and is_source), is_test
end

local function alternate()
  local file, is_source, is_test = is_test_file()
  local alt_file = file
  if is_test then
    alt_file = string.gsub(file, '_test.go', '.go')
  elseif is_source then
    alt_file = vim.fn.expand('%:r') .. '_test.go'
  else
    vim.notify('not a go file', vim.log.levels.ERROR)
  end
  return alt_file
end

local function switch(bang, cmd)
  local alt_file = alternate()
  if not vim.fn.filereadable(alt_file) and not vim.fn.bufexists(alt_file) and not bang then
    vim.notify("couldn't find " .. alt_file, vim.log.levels.ERROR)
    return
  elseif #cmd <= 1 then
    local ocmd = 'e ' .. alt_file
    vim.cmd(ocmd)
  else
    local ocmd = cmd .. ' ' .. alt_file
    vim.cmd(ocmd)
  end
end

return {
  setup = function(bufnr)
    vim.keymap.set('n', '<Leader>ga', function()
      switch(true, '')
    end, { buffer = bufnr, desc = '[LSP:gopls] Alternate or create test file' })

    vim.keymap.set('n', '<Leader>gA', function()
      switch(true, 'vsplit')
    end, { buffer = bufnr, desc = '[LSP:gopls] Alternate or create test file in vsplit' })
  end,
}
