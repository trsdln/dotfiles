" Toggle spell checking
" Usually I don't need this so disabled by default
nnoremap <Leader>st :call <SID>ToggleSpellCheck()<CR>

function! s:ToggleSpellCheck()
  if &spell
    set nospell
    echo 'Spellcheck disabled'
  else
    set spell spelllang=en_us
    echo 'Spellcheck enabled'
  endif
endfunction
