local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- augroup('show_signcolumn', { clear = true })
-- autocmd({ 'BufRead', 'BufNewFile' }, {
--   group = 'show_signcolumn',
--   pattern = '*',
--   command = 'setlocal signcolumn=yes',
-- })

-- Trim white spaces before writing
autocmd({ 'BufWritePre' }, {
  group = augroup('remove_white_spaces', { clear = true }),
  pattern = '*',
  callback = function()
    local _, client = next(vim.lsp.buf_get_clients())
    -- Skip if LSP provides formatting
    if
      vim.lsp.buf_is_attached()
      and client
      and client.server_capabilities.documentFormattingProvider
    then
      return
    end

    vim.cmd([[%s/\s\+$//e]])
  end,
})

autocmd('TextYankPost', {
  group = augroup('yank_post', { clear = true }),
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch',
      timeout = 300,
    })
  end,
})

augroup('autoqf', { clear = true })
autocmd('QuickFixCmdPost', {
  group = 'autoqf',
  pattern = '[^l]*',
  command = 'cwindow'
})

autocmd('QuickFixCmdPost', {
  group = 'autoqf',
  pattern = 'l*',
  command = 'lwindow'
})

autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = '*.heex',
  command = [[setlocal ft=html syntax=html]],
})

autocmd({ 'BufNewFile', 'BufRead' }, {
  desc = 'Set file type for Dockerfile*',
  pattern = 'Dockerfile*',
  command = [[set ft=dockerfile]],
})

autocmd('TermOpen', {
  group = augroup('term_open_insert', { clear = true }),
  pattern = { 'FTerm', 'term://*' },
  command = [[
    startinsert
    setlocal nonumber norelativenumber nospell signcolumn=no noruler
  ]],
})

autocmd({ 'BufWinEnter', 'WinEnter' }, {
  group = augroup('term_insert', { clear = true }),
  pattern = { 'FTerm' },
  command = [[
    startinsert
  ]],
})

autocmd('FileType', {
  pattern = { 'gitcommit' },
  command = [[
    setlocal nonumber signcolumn=no
  ]],
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd('FileType', {
  group = augroup('close_with_q', { clear = true }),
  pattern = {
    'PlenaryTestPopup',
    'help',
    'lspinfo',
    'man',
    'notify',
    'qf',
    'spectre_panel',
    'startuptime',
    'tsplayground',
    'checkhealth',
    'neotest-output',
    'neotest-summary',
    'neotest-output-panel',
    'guihua',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<CR>', { buffer = event.buf, silent = true })
    vim.cmd([[
      setlocal colorcolumn=0
      stopinsert
    ]])
  end,
})

autocmd('FileType', {
  pattern = 'man',
  command = [[nnoremap <buffer><silent> q :quit<CR>]],
})

-- NOTE: noice.nvim uses notifications
-- local cmd_timer = nil
-- augroup('clear_cmdline', { clear = true })
-- autocmd('CmdlineLeave', {
--   group = 'clear_cmdline',
--   pattern = '*',
--   callback = function()
--     cmd_timer = vim.defer_fn(function()
--       vim.api.nvim_command('echo ''')
--       cmd_timer = nil
--     end, 5000)
--   end,
-- })

-- autocmd({ 'CmdlineEnter', 'CmdlineChanged' }, {
--   group = 'clear_cmdline',
--   pattern = '*',
--   callback = function()
--     if cmd_timer ~= nil then
--       cmd_timer:stop()
--     end
--   end,
-- })

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  group = augroup('checktime', { clear = true }),
  command = 'checktime',
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ 'VimResized' }, {
  group = augroup('resize_splits', { clear = true }),
  callback = function()
    vim.cmd('tabdo wincmd =')
  end,
})
