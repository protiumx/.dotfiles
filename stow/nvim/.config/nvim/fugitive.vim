function! ToggleGStatus()
  if buflisted(bufname('.git/index'))
    bd .git/index
  else
    vertical Git | vertical resize 40
  endif
endfunction

command ToggleGStatus :call ToggleGStatus()
nmap <F3> :ToggleGStatus<CR>
nmap <Leader>gj :diffget //3<CR>
nmap <Leader>gf :diffget //2<CR>
