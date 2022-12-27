vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 0
vim.g.netrw_liststyle = 3 -- Tree-style view

vim.cmd [[
  syntax sync minlines=3000
  filetype plugin indent on
]]

vim.opt.shell = 'zsh'
vim.opt.background = 'dark'
vim.opt.showtabline = 0
vim.opt.hidden = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.updatetime = 200
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.sessionoptions:append { 'winpos', 'terminal' }
vim.opt.shortmess:append { c = true, F = true }
vim.opt.wrap = false
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.o.completeopt = 'menuone,noselect'

vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.cursorline = false
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

vim.opt.showmode = false
vim.opt.startofline = false

vim.opt.wildignore = '*.o,*.obj,*~,*.exe,*.a,*.pdb,*.lib'
vim.opt.wildignore:append('*.so,*.pyc,*.pyo,*.bin,*.dex')
vim.opt.wildignore:append('*.log,*.pyc,*.sqlite,*.sqlite3,*.min.js,*.min.css,*.tags')
vim.opt.wildignore:append('*.zip,*.7z,*.rar,*.gz,*.tar,*.gzip,*.bz2,*.tgz,*.xz')
vim.opt.wildignore:append('*.png,*.jpg,*.gif,*.bmp,*.tga,*.pcx,*.ppm,*.img,*.iso')
vim.opt.wildignore:append('*.pdf,*.dmg,*.app,*.ipa,*.apk,*.mobi,*.epub')
vim.opt.wildignore:append('*.mp4,*.avi,*.flv,*.mov,*.mkv,*.swf,*.swc')
vim.opt.wildignore:append('*.ppt,*.pptx,*.doc,*.docx,*.xlt,*.xls,*.xlsx,*.odt,*.wps')
vim.opt.wildignore:append('*/.git/*,*.DS_Store')
vim.opt.wildignore:append('*/node_modules/*,*/build/*,*/logs/*,*/dist/*,*/tmp/*')
