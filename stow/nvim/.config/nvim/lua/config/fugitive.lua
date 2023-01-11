local M = {}

function M.setup()
  vim.keymap.set('n', '<F3>', function()
    local name = vim.fn.bufname('fugitive:///*/.git//')
    if name ~= '' and vim.fn.buflisted(name) ~= 0 then
      vim.cmd [[ execute ":bd" bufname('fugitive:///*/.git//') ]]
    else
      vim.cmd [[vertical Git | vertical resize 40 | setlocal noequalalways wrap readonly nomodifiable noswapfile]]
    end
  end)

  vim.keymap.set('n', '<Leader>Go', ':G | only<CR>', { silent = true })
end

return M
