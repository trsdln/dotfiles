" mnemonic: browse
nnoremap <Leader>br :call <sid>OpenAnything()<cr>

let s:url_regexp = '\vhttps?:\/\/[a-z\.\/#0-9%\?=&_\-]+'

function! s:OpenAnything()
  let current_word = expand('<cWORD>')

  let current_url = shellescape(matchstr(current_word, s:url_regexp))
  " current_url will have 2 characters if url wasn't found
  if strlen(current_url) > 2
    call g:XDGOpen(current_url)
  elseif &filetype ==# 'json'
    " probably intention was to open NPM package web page
    let package_name = matchstr(getline('.'), '\v"\zs.+\ze"\:')
    call s:OpenNPMPackageURL(package_name)
  elseif &filetype ==# 'javascript'
    let token = s:ParseJSWord(current_word)
    if filereadable(token)
      call g:XDGOpen(token)
    else
      call s:OpenNPMPackageURL(token)
    endif
  else
    call g:XDGOpen(current_word)
  endif
endfunction

function! s:ParseJSWord(word)
  let tokens = split(a:word, '\v[''";]')
  let non_empty_tkns = filter(tokens, 'v:val !=# ""')
  let middle_idx = float2nr(len(non_empty_tkns) / 2)
  if middle_idx >= 0
    return non_empty_tkns[middle_idx]
  endif
  return non_empty_tkns[0]
endfunction

function! s:OpenNPMPackageURL(package_name)
  call g:XDGOpen('https://npmjs.com/package/' . a:package_name)
endfunction

function! g:XDGOpen(url)
  let open_app_name = has('macunix') ? 'open' : 'xdg-open'
  call system(open_app_name . " '" . a:url . "' &")
  echo open_app_name . " " . a:url
endfunction
