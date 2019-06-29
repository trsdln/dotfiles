if !executable('rg')
  echoerr "ripgrep executable not found!"
endif

runtime plugin/grepper.vim  " initialize g:grepper with default values
let g:grepper.tools = ['rg']
" Group matches by file/path
let g:grepper.rg.grepprg .= ' --sort path'

call g:SetupCommandAlias("G", "Grepper")

nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

nnoremap <leader>gw :Grepper -cword -noprompt<cr>

nnoremap <leader>gd :GrepJsDefinition<cr>
command! GrepJsDefinition call s:GrepJsDefinition()

function! s:GrepJsDefinition()
  let target = expand('<cword>')
  let escaped_target = shellescape(fnameescape(target))

  let js_def_exp ='\bconst\s' . escaped_target . '\b\s?=\s?'
  let js_destruct_def_exp ='\bconst\s\{.+\b' . escaped_target . '\b.+\}\s?=\s?'
  let gql_def_exp = '\b(input|type|enum|fragment|query)\s' . escaped_target . '\s?\{'

  execute "silent Grepper -noprompt -query '(" . js_def_exp . "|" . gql_def_exp . "|" . js_destruct_def_exp . ")'"
endfunction
