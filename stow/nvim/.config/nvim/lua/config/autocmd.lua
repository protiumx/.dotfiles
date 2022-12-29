local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup('sign_column_all', {})
autocmd({ 'BufRead', 'BufNewFile' }, {
  group = 'sign_column_all',
  pattern = '*',
  command = 'setlocal signcolumn=yes',
})

-- Trim white spaces before writing
augroup('write_pre', {})
autocmd({ 'BufWritePre' }, {
  group = 'write_pre',
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

augroup('highlight_yank', {})
autocmd('TextYankPost', {
  group = 'highlight_yank',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch',
      timeout = 300,
    })
  end,
})

augroup('elixir_tpl', {})
autocmd({ 'BufNewFile', 'BufRead' }, {
  group = 'elixir_tpl',
  pattern = '*.heex',
  command = [[setlocal ft=html syntax=html]],
})

augroup('term_open_insert', {})
autocmd('TermOpen', {
  group = 'term_open_insert',
  pattern = '*',
  command = [[
    startinsert
    setlocal nonumber norelativenumber nospell laststatus=0 signcolumn=no noruler
  ]],
})

local cmd_timer = nil
augroup('clear_cmdline', {})
autocmd('CmdlineLeave', {
  group = 'clear_cmdline',
  pattern = '*',
  callback = function()
    cmd_timer = vim.defer_fn(function()
      vim.api.nvim_command('echo ""')
      cmd_timer = nil
    end, 3000)
  end,
})

autocmd('CmdlineEnter', {
  group = 'clear_cmdline',
  pattern = '*',
  callback = function()
    if cmd_timer then
      cmd_timer:stop()
    end
  end,
})

local kitty_title = function(leaving)
  local title = ''
  local arg = vim.api.nvim_eval('argv(0)')
  if not arg then
    title = 'nvim'
  elseif not leaving then
    if vim.fn.isdirectory(arg) then
      title = 'nvim ~ ' .. vim.fn.expand('%:p:h:t')
    else
      title = 'nvim ~ ' .. arg
    end
  end

  vim.fn.system('kitty @ set-window-title "' .. title .. '"')
  vim.fn.system('kitty @ set-tab-title "' .. title .. '"')
end

augroup('kitty_title', {})
autocmd('VimEnter', {
  group = 'kitty_title',
  pattern = '* ++once',
  callback = function()
    kitty_title(false)
  end,
})

autocmd('VimLeave', {
  group = 'kitty_title',
  pattern = '* ++once',
  callback = function()
    kitty_title(true)
  end,
})

-- dont list quickfix buffers
autocmd('FileType', {
  pattern = 'qf',
  callback = function()
    vim.opt_local.buflisted = false
  end,
})
