nnoremap <buffer> <Leader>bn :OpenNpmPage<cr>
command! OpenNpmPage call s:OpenNpmPage()

function! s:OpenNpmPage()
  let package_name = matchstr(getline('.'), '\v"\zs.+\ze"\:')
  call g:OpenURL('https://npmjs.com/package/' . package_name)
endfunction
