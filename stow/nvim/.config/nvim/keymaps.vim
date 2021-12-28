" Delete/change to blackhole register
nnoremap <Leader>d "_d
vnoremap <Leader>d "_d
nnoremap <Leader>c "_c
vnoremap <Leader>c "_c

" Prepare replace of current word
nnoremap <Leader>r :%s/\<<C-r><C-w>\>//g<Left><Left>

" Remap C-c to esc in insert mode
inoremap <C-c> <esc>
nnoremap ; :

" Clears hlsearch after doing a search, otherwise just does normal <CR> stuff
nnoremap <expr> <CR> {-> v:hlsearch ? ":nohl\<CR>" : "\<CR>"}()

" Quick-save
nmap <Leader>w :w<CR>

nnoremap <silent> Q <nop>

" Close current split
nnoremap <Leader>q <C-w>q

" Copy from cursor to end of line
nnoremap Y y$

" Jump next/prev but centered
nnoremap n nzzzv
nnoremap N Nzzzv

" Opens line below or above the current line
inoremap <S-CR> <C-O>o
inoremap <C-CR> <C-O>O

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

" Navigate buffers
nnoremap <S-l> :bnext<CR>
nnoremap <S-h> :bprevious<CR>
" Toggle between buffers current and prev buffer
nnoremap <Leader><Leader> <C-^>
" New buffer vertical split
nnoremap <Leader>vs :vnew<cr>
" Close buffer without changing window layout
nnoremap :: :bp\|bd #<CR>

" Select everything
nnoremap <C-A> ggVG

" Open new file adjacent to current file
nnoremap <Leader>o :e <C-R>=expand("%:p:h") . "/" <CR>
" Open new adjacent file in vertical split
nnoremap <Leader>vo :vsp \| :e <C-R>=expand("%:p:h") . "/" <CR>

" Paste formatted
nnoremap p p=`]
nnoremap <C-p> p
