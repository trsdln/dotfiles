nnoremap <leader>cc :CleanHiddenBuffers<cr>

command CleanHiddenBuffers call s:CleanHiddenBuffers()

function! s:CleanHiddenBuffers()
    let tpbl=[]
    call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
    let buffers_to_delete = filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
    execute 'bwipeout' join(buffers_to_delete)
endfunction
