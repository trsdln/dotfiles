nnoremap <leader>ac :CleanEmptyBuffers<cr>
nnoremap <leader>cc :CleanHiddenBuffers<cr>

command CleanEmptyBuffers call s:CleanEmptyBuffers()

" Similar to CleanEmptyBuffers. May end up leaving only this one
command CleanHiddenBuffers call s:CleanHiddenBuffers()

function! s:CleanEmptyBuffers()
    let bufs=filter(range(1, bufnr('$')), 'bufexists(v:val) && '.
                                          \'empty(getbufvar(v:val, "&buftype")) && '.
                                          \'!filereadable(bufname(v:val))')
    if !empty(bufs)
        execute 'bwipeout' join(bufs)
    endif
endfunction

function! s:CleanHiddenBuffers()
    let tpbl=[]
    call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
    let buffers_to_delete = filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
    execute 'bwipeout' join(buffers_to_delete)
endfunction
