local utils = require('config.utils')
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Trim white spaces before writing
autocmd({ 'BufWritePre' }, {
  group = augroup('remove_white_spaces', { clear = true }),
  pattern = '*',
  callback = function(args)
    local _, client = next(vim.lsp.get_clients())
    -- Skip if LSP provides formatting
    if
      client
      and vim.lsp.buf_is_attached(args.buf, client.id)
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
      higroup = 'OnYank',
      timeout = 400,
    })
  end,
})

augroup('autoqf', { clear = true })
autocmd('QuickFixCmdPost', {
  group = 'autoqf',
  pattern = '[^l]*',
  command = 'cwindow',
})

autocmd('QuickFixCmdPost', {
  group = 'autoqf',
  pattern = 'l*',
  command = 'lwindow',
})

autocmd('TermOpen', {
  group = augroup('term_open_insert', { clear = true }),
  pattern = { 'FTerm', 'term://*' },
  command = [[
    setlocal nonumber norelativenumber nospell signcolumn=no noruler scrolloff=0
    startinsert
  ]],
})

autocmd('FileType', {
  pattern = { 'gitcommit' },
  command = [[
    setlocal nonumber signcolumn=no
  ]],
})

-- Close some filetypes with <q>
vim.api.nvim_create_autocmd('FileType', {
  group = augroup('close_with_q', { clear = true }),
  pattern = {
    'help',
    'lspinfo',
    'man',
    'notify',
    'qf',
    'git',
    'startuptime',
    'tsplayground',
    'checkhealth',
    'neotest-output',
    'neotest-summary',
    'neotest-output-panel',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<CR>', { buffer = event.buf, silent = true })
    vim.cmd([[
      setlocal colorcolumn=0
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

-- Check if any buffer changed when after leaving the terminal
autocmd({ 'TermClose', 'TermLeave' }, {
  group = augroup('checktime', { clear = true }),
  command = 'checktime',
})

-- Resize splits if nvim window got resized
autocmd({ 'VimResized' }, {
  group = augroup('resize_splits', { clear = true }),
  callback = function()
    vim.cmd('tabdo wincmd =')
  end,
})

autocmd('BufWritePost', {
  group = augroup('mk-spell', { clear = true }),
  pattern = '*.utf-8.add',
  callback = function(args)
    vim.cmd('mkspell! ' .. args.file)
  end,
})
