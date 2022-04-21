augroup compileandrun
  autocmd!
  autocmd filetype rust nmap <f5> :w <bar> :!cargo run <cr>
  autocmd filetype rust nmap <f6> :w <bar> :!cargo build <cr>
  autocmd filetype python nmap <f5> :w <bar> :!python % <cr>
  autocmd FileType go nmap <f5> <Plug>(go-run)
augroup END

" Remove white spaces before saving
"autocmd BufWritePre * :%s/\s\+$//e

augroup highlight_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=500}
augroup END

augroup neovim_terminal
  autocmd!
  " Enter Terminal-mode (insert) automatically
  autocmd TermOpen * startinsert
  " Disables number lines on terminal buffers
  autocmd TermOpen * :set nonumber norelativenumber nospell
augroup END
