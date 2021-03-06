if !executable('rg')
  echoerr "ripgrep executable not found!"
endif

runtime plugin/grepper.vim  " initialize g:grepper with default values
let g:grepper.tools = ['rg']

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
  let js_function_def_exp ='\bfunction\s' . escaped_target . '\s?\('
  let js_class_def_exp = '\bclass\s' . escaped_target . '\b'
  let gql_def_exp = '\b(input|type|enum|fragment|query)\s' . escaped_target . '\s?\{'

  execute "silent Grepper -noprompt -query -s -- '("
        \ . js_def_exp . "|"
        \ . js_function_def_exp . "|"
        \ . js_class_def_exp . "|"
        \ . js_destruct_def_exp . "|"
        \ . gql_def_exp . ")'"
endfunction

command! GrepGqlEndpointUsage call s:GrepGqlEndpointUsage()

function! s:GrepGqlEndpointUsage()
  let target = expand('<cword>')
  let escaped_target = shellescape(fnameescape(target))
  " Checks for:
  " * resolver with args `field(`
  " * resolver without args `field {`
  " * plain field `field`
  " * plain field with comment `field # some comment`
  let endpoint_usage_exp = '\b' . escaped_target . '((\s\{|\()|\s+\#|$)'
  execute "silent Grepper -noprompt -query -s -- '" . endpoint_usage_exp . "'"
endfunction
