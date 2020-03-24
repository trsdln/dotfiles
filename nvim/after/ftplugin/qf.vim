" source: https://stackoverflow.com/questions/16743112/open-item-from-quickfix-window-in-vertical-split
" This is only available in the quickfix window, owing to the filetype
" restriction on the autocmd (see below).
function! <SID>OpenQuickfix(new_split_cmd, extra_cmd)
  " 1. the current line is the result idx as we are in the quickfix
  let l:qf_idx = line('.')
  " 2. jump to the previous window
  wincmd p
  " 3. switch to a new split (the new_split_cmd will be 'vnew' or 'split')
  execute a:new_split_cmd
  " 4. open the 'current' item of the quickfix list in the newly created buffer
  "    (the current means, the one focused before switching to the new buffer)
  execute l:qf_idx . 'cc'

  " 5. execute additional command if provided
  if a:extra_cmd !=# ""
    execute a:extra_cmd
  endif
endfunction

" Those match Dirvish mappings for consistency
" Open at horizontal split
nnoremap <buffer> <silent> o  :call <SID>OpenQuickfix("split", "")<CR>
" Open at horizontal split and close quick list
nnoremap <buffer> <silent> O  :call <SID>OpenQuickfix("split", "cclose")<CR>
" Open at horizontal split and go back to quick list
nnoremap <buffer> <silent> go :call <SID>OpenQuickfix("split", "copen")<CR>
" Open at vertical split
nnoremap <buffer> <silent> a  :call <SID>OpenQuickfix("vnew", "")<CR>
" Open at vertical split and close quick list
nnoremap <buffer> <silent> A  :call <SID>OpenQuickfix("vnew", "cclose")<CR>
" Open at vertical split and go back to quick list
nnoremap <buffer> <silent> ga :call <SID>OpenQuickfix("vnew", "copen")<CR>
" Open at last visited window: <CR>
" Preview at last visited window
nnoremap <buffer> <silent> g<CR> <CR><C-W>p
