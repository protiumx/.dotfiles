augroup compileandrun
  autocmd!
  autocmd filetype rust nmap <f5> :w <bar> :!cargo run <cr>
  autocmd filetype rust nmap <f6> :w <bar> :!cargo build <cr>
  autocmd filetype python nmap <f5> :w <bar> :!python % <cr>
  autocmd FileType go nmap <f5> <Plug>(go-run)
augroup END

autocmd BufNewFile,BufRead *.heex set ft=html syntax=html

augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=500}
augroup END

augroup neovim_terminal
  autocmd!
  " Enter Terminal-mode (insert) automatically
  autocmd TermOpen * startinsert
  " Disables number lines on terminal buffers
  autocmd TermOpen * setlocal nonumber norelativenumber nospell
  autocmd TermOpen * setlocal signcolumn=no
augroup END

" Clear last command after 2 seconds
augroup clearcmdline
  autocmd!
  function! Echo_Nothing(timer)
      echo ''
  endfunction

  autocmd CmdlineLeave * call timer_start(2000, 'Echo_Nothing')
augroup END
