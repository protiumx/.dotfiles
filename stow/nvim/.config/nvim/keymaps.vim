" Reload config
nnoremap <Leader>so :so ~/.config/nvim/init.vim<CR>

" Delete/change to blackhole register
nnoremap <Leader>d "_d
vnoremap <Leader>d "_d
nnoremap <Leader>c "_c
vnoremap <Leader>c "_c

" Insert a build date
nnoremap <Leader>db "=strftime('%Y%m%d%H%M')<CR>p

" Prepare replace all occurrences of current word
nnoremap <Leader>rw :%s/\<<C-r><C-w>\>//g<Left><Left>

" Remap C-c to esc in insert mode
inoremap <C-c> <esc>

" Clears hlsearch after doing a search, otherwise just does normal <CR> stuff
nnoremap <expr> <CR> {-> v:hlsearch ? ":nohl\<CR>" : "\<CR>"}()

nnoremap <silent> Q <nop>

" Copy from cursor to end of line
nnoremap Y y$

" Jump next/prev but centered
nnoremap <silent> n nzzzv
nnoremap <silent> N Nzzzv
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" Down/up centered
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" Moving lines up or down preserving format
vnoremap <silent>J :m '>+1<CR>gv=gv
vnoremap <silent>K :m '<-2<CR>gv=gv
inoremap <silent><C-j> <Esc>:m .+1<CR>==gi
inoremap <silent><C-k> <Esc>:m .-2<CR>==gi
nnoremap <silent><Leader>j :m .+1<CR>==
nnoremap <silent><Leader>k :m .-2<CR>==

" Resize windows
nnoremap <silent><C-Up> :resize -2<CR>
nnoremap <silent><C-Down> :resize +2<CR>
nnoremap <silent><Leader><Left> :vertical resize -2<CR>
nnoremap <silent><Leader><Right> :vertical resize +2<CR>

" Copy to macOS clipboard
vnoremap <silent> <C-y> "*y
" Toggle between current and prev buffers
nnoremap <silent> `` <C-^>
" Close buffer without changing window layout
nnoremap <silent>-- :bp\|bd #<CR>
" Go next/prev buffer using Tab
nnoremap <silent> <Tab> :bn<CR>
nnoremap <silent> <S-Tab> :bp<CR>

" Close all buffers except current
nnoremap <Leader>xa :%bd\|e#\|bd#<cr>\|'"

" Select all
nnoremap <C-S> ggVG
inoremap <C-S> <ESC>ggVG
vnoremap <C-S> <ESC>ggVG

" Open new file adjacent to current file
nnoremap <Leader>o :e <C-R>=expand("%:h") . "/" <CR>
" Open new adjacent file in vertical split
nnoremap <Leader>vo :vsp \| :e <C-R>=expand("%:h") . "/" <CR>

" Paste formatted
nnoremap <silent>p p=`]
nnoremap <silent>P P=`]
nnoremap <silent><C-p> p

inoremap <silent><F12> <esc>:term ++close<CR>
nnoremap <silent><F12> :term ++close<CR>
inoremap <silent><F10> <esc>:vs term://zsh<CR>
nnoremap <silent><F10> :vs term://zsh<CR>
" Close terminal
tnoremap <silent><C-q> <C-\><C-n>:bd!<CR>
" Esc goes to normal mode
tnoremap <silent><Esc> <C-\><C-n>

" Exec current line as bash code
nmap <Leader>sh !!zsh<CR>
" Copy current file relative path to macos clipboard
nmap <silent><Leader>P :let @*=expand('%:~:.')<CR>
