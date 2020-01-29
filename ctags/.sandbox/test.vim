nnoremap <leader>c :call TestCtagsConf()<cr>

function! TestCtagsConf()
  let ctagsRes = system('cd ctags/.sandbox && ctags -o tags index.js')
  vsplit | edit ./ctags/.sandbox/tags
  echom ctagsRes
endfunction
