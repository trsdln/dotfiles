" Detailed Ag regexp spec: `man pcrepattern`

" Use ripgrep if available
if executable('rg')
  " I want to search hidden files (excluding .git of course)
  let g:ackprg = 'rg --sort path --vimgrep --hidden'
else
  echoerr "ripgrep executable not found!"
endif

let g:ack_autofold_results = 1


" Do not open first file from results window
call g:SetupCommandAlias("A", "Ack!")

" Do not apply plugin's mappings because
" custom and persistent ones exist at QuickFix filetype config
let g:ack_apply_qmappings = 0

" Find partial word matches as well
nnoremap <leader>g :set operatorfunc=<SID>AckOperator<cr>g@
vnoremap <leader>g :<c-u>call <SID>AckOperator(visualmode())<cr>

command AckWord call s:AckWord()
nnoremap <leader>aw :AckWord<cr>

command AckJsDefinition call s:AckJsDefinition()
nnoremap <leader>ad :AckJsDefinition<cr>

function! s:AckOperator(type)
  let reg_save = @@

  if a:type ==# 'v'
    normal! `<v`>y
  elseif a:type ==# 'char'
    normal! `[v`]y
  else
    return
  endif

  execute "Ack! " . shellescape(@@)

  let @@ = reg_save
endfunction

function! s:AckWord()
  let target = expand('<cword>')
  execute "Ack! '\\b" . shellescape(target) . "\\b'"
endfunction

function! s:AckJsDefinition()
  let target = expand('<cword>')
  let escaped_target = shellescape(target)

  let js_def_exp ='\bconst\s' . escaped_target . '\b\s?=\s?'
  let js_destruct_def_exp ='\bconst\s\{.+\b' . escaped_target . '\b.+\}\s?=\s?'
  let gql_def_exp = '\b(input|type|enum|fragment|query)\s' . escaped_target . '\s?\{'

  execute "Ack! '(" . js_def_exp . "|" . gql_def_exp . "|" . js_destruct_def_exp . ")'"
endfunction
