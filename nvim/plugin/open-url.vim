" Quickly open url under cursor at browser
nnoremap <Leader>br :call <sid>OpenCurrentURL()<cr>

let s:url_regexp = '\vhttps?:\/\/[a-z\.\/#0-9%\?=&_\-]+'

function! s:OpenCurrentURL()
  let current_word = expand('<cWORD>')
  let current_url = shellescape(matchstr(current_word, s:url_regexp))
  " current_url will have 2 characters if url wasn't found
  if strlen(current_url) > 2
    call g:XDGOpen(current_url)
  elseif &filetype ==# 'json'
    " probably intention was to open NPM package page
    let package_name = matchstr(getline('.'), '\v"\zs.+\ze"\:')
    call g:XDGOpen('https://npmjs.com/package/' . package_name)
  else
    call g:XDGOpen(current_word)
  endif
endfunction

function! g:XDGOpen(url)
  let open_app_name = has('macunix') ? 'open' : 'xdg-open'
  call system(open_app_name . " '" . a:url . "' &")
  echo open_app_name . " " . a:url
endfunction
