vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 0
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.netrw_liststyle = 3 -- Tree-style view

vim.cmd [[
  syntax sync minlines=3000
  filetype plugin indent on
  set fillchars=diff:\ ,
  set pumheight=10
  set undolevels=1000
]]

vim.opt.shell = 'zsh'
vim.opt.background = 'dark'
vim.opt.showtabline = 0
vim.opt.hidden = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.updatetime = 200
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.sessionoptions:append { 'curdir', 'winsize' }
vim.opt.shortmess:append { c = true, F = true, s = true }
vim.opt.wrap = false
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.ignorecase = true
vim.opt.smartindent = true
vim.opt.listchars = { eol = '', tab = '  ' }
vim.opt.list = true
vim.opt.statusline = '2'
vim.o.completeopt = 'menu,menuone,noselect'

vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.cursorline = true
vim.opt.colorcolumn = '100'

vim.opt.isfname:append('@-@')
vim.opt.mouse = 'a'
vim.opt.encoding = 'UTF-8'
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.smartcase = true

vim.opt.spell = true
vim.opt.spelllang = 'en_us'
vim.opt.spellcapcheck = ''
vim.opt.spelloptions = 'camel'

vim.opt.showmode = false
vim.opt.startofline = false

vim.opt.wildmode = 'full'     -- Shows a menu bar as opposed to an enormous list
vim.opt.wildignorecase = true -- Ignore case when completing file names and directories
vim.opt.wildignore = {
  '*.o', '*.obj', '*~', '*.exe', '*.a', '*.pdb', '*.lib',
  '*.so', '*.pyc', '*.pyo', '*.bin', '*.dex',
  '*.log', '*.pyc', '*.sqlite', '*.sqlite3', '*.min.js', '*.min.css', '*.tags',
  '*.zip', '*.7z', '*.rar', '*.gz', '*.tar', '*.gzip', '*.bz2', '*.tgz', '*.xz',
  '*.png', '*.jpg', '*.gif', '*.bmp', '*.tga', '*.pcx', '*.ppm', '*.img', '*.iso',
  '*.pdf', '*.dmg', '*.app', '*.ipa', '*.apk', '*.mobi', '*.epub',
  '*.mp4', '*.avi', '*.flv', '*.mov', '*.mkv', '*.swf', '*.swc',
  '*.ppt', '*.pptx', '*.doc', '*.docx', '*.xlt', '*.xls', '*.xlsx', '*.odt', '*.wps',
  '*/.git/*', '*.DS_Store',
  '*/node_modules/*', '*/build/*', '*/logs/*', '*/dist/*', '*/tmp/*',
}

vim.filetype.add({
  pattern = {
    ['[jt]sconfig.*.json'] = 'jsonc',
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
