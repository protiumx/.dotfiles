local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local sign_group = augroup('sign', {})
autocmd({'BufRead', 'BufNewFile'}, {
  group = sign_group,
  pattern = '*',
  command = 'setlocal signcolumn=yes',
})

-- Trim white spaces before writing
local trim_group = augroup('trim', {})
autocmd({"BufWritePre"}, {
  group = trim_group,
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

local yank_group = augroup('HighlightYank', {})
autocmd('TextYankPost', {
  group = yank_group,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({
        higroup = 'IncSearch',
        timeout = 500,
    })
  end,
})

local elexir_tpl_group = augroup('elixir', {})
autocmd({'BufNewFile', 'BufRead'}, {
  group = elexir_tpl_group,
  pattern = '*.heex',
  command = [[setlocal ft=html syntax=html]],
})

local term_group = augroup('term', {})
autocmd('TermOpen', {
  group = term_group,
  pattern = '*',
  command = [[startinsert]],
})
autocmd('TermOpen', {
  group = term_group,
  pattern = '*',
  command = [[setlocal nonumber norelativenumber nospell laststatus=0 signcolumn=no noruler]],
})


local clear_cmd_group = augroup('clear_cmd', {})
local cmd_timer = vim.loop.new_timer()

autocmd('CmdlineLeave', {
  group = clear_cmd,
  pattern = '*',
  callback = function()
    cmd_timer:start(2000, 0,  vim.schedule_wrap(function()
      vim.api.nvim_command('echo ""')
    end))
  end,
})

autocmd('CmdlineEnter', {
  group = clear_cmd,
  pattern = '*',
  callback = function()
    cmd_timer:stop()
  end,
})


local kitty_group = augroup('kitty', {})
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

autocmd('VimEnter', {
  group = kitty_group,
  pattern = '* ++once',
  callback = function()
    kitty_title(false)
  end,
})

autocmd('VimLeave', {
  group = kitty_group,
  pattern = '* ++once',
  callback = function()
    kitty_title(true)
  end,
})
