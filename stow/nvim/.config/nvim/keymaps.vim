" Delete/change to blackhole register
nnoremap <Leader>d "_d
vnoremap <Leader>d "_d
nnoremap <Leader>c "_c
vnoremap <Leader>c "_c

" Build date
nnoremap <Leader>db "=strftime('%Y%m%d%H%M')<CR>p

" Prepare replace of current word
nnoremap <Leader>rw :%s/\<<C-r><C-w>\>//g<Left><Left>

" Remap C-c to esc in insert mode
inoremap <C-c> <esc>
nnoremap ; :
vnoremap ; :

" Clears hlsearch after doing a search, otherwise just does normal <CR> stuff
nnoremap <expr> <CR> {-> v:hlsearch ? ":nohl\<CR>" : "\<CR>"}()

nnoremap <silent> Q <nop>

" Close current split
nnoremap <Leader>wq <C-w>q

" Copy from cursor to end of line
nnoremap Y y$

" Jump next/prev but centered
nnoremap <silent> n nzzzv
nnoremap <silent> N Nzzzv
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" Moving lines up or down preserving format
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
inoremap <C-j> <esc>:m .+1<CR>==gi
inoremap <C-k> <esc>:m .-2<CR>==gi
nnoremap <Leader>j :m .+1<CR>==
nnoremap <Leader>k :m .-2<CR>==

" Navigate windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Resize windows
nnoremap <C-Up> :resize -2<CR>
nnoremap <C-Down> :resize +2<CR>
nnoremap <C-Left> :vertical resize -2<CR>
nnoremap <C-Right> :vertical resize +2<CR>

" Copy to macOS clipboard
vnoremap <silent> <C-y> "*y
" Toggle between current and prev buffers
nnoremap <silent> `` <c-^>
" New buffer vertical split
nnoremap <Leader>vs :vnew<cr>
" Close buffer without changing window layout
nnoremap <silent>:: :bp\|bd #<CR>
" Go next/prev buffer
nnoremap <silent> <Tab> :bn<CR>
nnoremap <silent> <S-Tab> :bp<CR>

" Close all but current buffer
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
nnoremap p p=`]
nnoremap P P=`]
nnoremap <C-p> p

inoremap <F12> <esc>:term<CR>
nnoremap <F12> :term<CR>
inoremap <F10> <esc>:vs term://zsh<CR>
nnoremap <F10> :vs term://zsh<CR>

" insert current file path
nnoremap <Leader>fp :let @+=expand('%:h')<CR>

" visual select words
inoremap <S-M-Left> <Esc>vb
inoremap <S-M-Right> <Esc>ve
" close terminal
tnoremap <C-q> <C-\><C-n>:bd!<CR>
tnoremap <Esc> <C-\><C-n>

" Begin new line above from insert mode
inoremap <M-Return> <C-o>O
inoremap <C-Return> <C-o>o

" Exec current line as bash code
nmap <Leader><Enter> !!zsh<CR>
