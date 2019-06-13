nnoremap <leader>c :call TestCtagsConf()<cr>

function! TestCtagsConf()
  let ctagsRes = system('cd ctags.d/.sandbox && ctags --options=NONE --options=js.ctags -o tags index.js')
  vsplit | edit ./ctags.d/.sandbox/tags
  echom ctagsRes
endfunction
