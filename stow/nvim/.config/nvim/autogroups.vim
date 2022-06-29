augroup compileandrun
  autocmd!
  autocmd filetype rust nmap <F5> :w <bar> :!cargo run <CR>
  autocmd filetype rust nmap <F6> :w <bar> :!cargo build <CR>
  autocmd filetype python nmap <F5> :w <bar> :!python % <CR>
  autocmd FileType go nmap <F5> :w <bar> :!go run % <CR>
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

  function! Clean(timer)
    echo ''
  endfunction

  function! Leave()  
      let g:timer = timer_start(2000, 'Clean')
  endfunction

  function! Enter()
    if exists("g:timer")
      call timer_stop(g:timer)
    endif
  endfunction

  autocmd CmdlineLeave * call Leave()
  autocmd CmdlineEnter * call Enter()
augroup END

augroup kitty_title
  function! SetTitle(leaving)
    let title = ''
    let arg = argv()[0]
    if !a:leaving
      if isdirectory(arg)
        let title = 'nvim ~ ' . expand('%:p:h:t')
      else
        let title = 'nvim ~ ' . arg
      endi
    endif

    call system('kitty @ set-window-title "' . title . '"')
    call system('kitty @ set-tab-title "' . title . '"')
  endfunction
  autocmd VimEnter * ++once call SetTitle(0)
  autocmd VimLeave * ++once call SetTitle(1)
augroup END

