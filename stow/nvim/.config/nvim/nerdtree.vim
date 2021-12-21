let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1
nnoremap <Leader>nf :NERDTreeFocus<CR>
nnoremap <Leader>nt :NERDTreeToggle %<CR>

" Check if NERDTree is open or active
function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" sync open file with NERDTree
" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

" Highlight currently open buffer in NERDTree
" autocmd BufEnter * call SyncTree()
let g:NERDTreeIgnore = ['^node_modules$', '^target$', '.git$', 'build$']

