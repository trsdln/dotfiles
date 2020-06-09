nnoremap <leader>cc :CleanHiddenBuffers<cr>

command CleanHiddenBuffers call s:CleanHiddenBuffers()

function! s:CleanHiddenBuffers()
  let tpbl=[]
  let closed = 0
  call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
  for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
    if getbufvar(buf, '&mod') == 0
      silent execute 'bwipeout' buf
      let closed += 1
    endif
  endfor
  echo "Cleaned " . closed . " hidden buffers"
  " source: https://stackoverflow.com/questions/8450919/how-can-i-delete-all-hidden-buffers
endfunction
