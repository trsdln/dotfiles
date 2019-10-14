" Quickly open url under cursor at browser
nnoremap <Leader>br :call <sid>OpenCurrentURL()<cr>

let s:url_regexp = '\vhttps?:\/\/[a-z\.\/#0-9%\?=&_\-]+'

function! s:OpenCurrentURL()
  let current_url = shellescape(matchstr(expand('<cWORD>'), s:url_regexp))
  call g:OpenURL(current_url)
endfunction

function! g:OpenURL(url)
  let open_app_name = has('macunix') ? 'open' : 'xdg-open'
  call system(open_app_name . " '" . a:url . "' &")
  echo "OpenURL " . a:url
endfunction