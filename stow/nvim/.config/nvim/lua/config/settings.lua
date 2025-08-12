local colors = require('config.colors')

vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 0

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.netrw_liststyle = 3

vim.g.omni_sql_no_default_maps = 1 -- Disable completion on sql files

vim.cmd([[
  syntax sync minlines=3000
  filetype plugin indent on
  set iskeyword-=_
  set iskeyword-==
  set iskeyword+=+
  set fillchars=diff:\ ,
  set pumheight=20
  set undolevels=100
  set grepprg=rg\ --vimgrep\ --smart-case\ --hidden\ --no-heading
  set grepformat=%f:%l:%c:%m
]])

vim.opt.shell = 'zsh'
vim.opt.background = 'dark'
vim.opt.showtabline = 0
vim.opt.cmdwinheight = 12
vim.opt.hidden = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.updatetime = 300
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.sessionoptions:append({ 'curdir', 'winsize' })
vim.opt.shortmess:append({ c = true, F = true, s = true })
vim.opt.wrap = false

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.listchars = { eol = '¬', tab = '  ' }
vim.opt.list = true
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force user to select one from the menu
vim.o.completeopt = 'menu,menuone,noselect'
vim.o.laststatus = 3

vim.opt.undofile = true
vim.opt.undodir = os.getenv('HOME') .. '/.nvim/undodir'

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.colorcolumn = '100'

vim.opt.mouse = 'a'
vim.opt.encoding = 'UTF-8'
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.spell = true
vim.opt.spelllang = 'en_us'
vim.opt.spellcapcheck = ''
vim.opt.spelloptions = 'camel'

vim.opt.showmode = false
vim.opt.startofline = false

vim.opt.wildmode = 'full' -- Shows a menu bar as opposed to an enormous list
vim.opt.wildignorecase = true -- Ignore case when completing file names and directories
vim.opt.wildignore = {
  '*.o',
  '*.lib',
  '*.so',
  '*.sqlite',
  '*.sqlite3',
  '*/.git/*',
  '*.DS_Store',
}

if vim.fn.has('wsl') == 1 then
  vim.g.clipboard = {
    name = 'WslClipboard',
    copy = {
      ['+'] = 'clip.exe',
      ['*'] = 'clip.exe',
    },
    paste = {
      ['+'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      ['*'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enabled = 0,
  }
end

vim.filetype.add({
  pattern = {
    ['[jt]sconfig.*.json'] = 'jsonc',
    ['Dockerfile*'] = 'dockerfile',
  },
  extension = {
    heex = 'html',
  },
})

local builtins = {
  '2html_plugin',
  'getscript',
  'getscriptPlugin',
  'gzip',
  'logiPat',
  'netrwPlugin',
  'rrhelper',
  'tar',
  'tarPlugin',
  'vimball',
  'vimballPlugin',
  'zip',
  'zipPlugin',
}

for _, plugin in ipairs(builtins) do
  vim.g['loaded_' .. plugin] = 1
end

vim.api.nvim_create_user_command('ToggleTransparency', function()
  colors.toggle_transparent()
end, {
  desc = 'Toggle transparency',
})

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
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
