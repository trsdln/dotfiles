nnoremap <buffer> cc :Gcommit --no-verify<cr>
nnoremap <buffer> ca :Gcommit --no-verify --amend<cr>
nnoremap <buffer> ce :Gcommit --no-verify --amend --reuse-message=HEAD<cr>

" Consistent with NERDtree/Ack's mappings
" Open at vsplit
nnoremap <buffer> s :call <SID>FugitiveOpenCurrentFileVSplit(0)<cr>
" Preview at vsplit
nnoremap <buffer> gs :call <SID>FugitiveOpenCurrentFileVSplit(1)<cr>

" Fixes not fully working Fugitive's `X` mapping at status window
nnoremap <buffer> rm :call <SID>FugitiveDeleteCurrentFile()<cr>

function s:FugitiveOpenCurrentFileVSplit(isPreview)
  let target = s:FugitiveStatusGetCurrentFile()
  if len(target) > 0
    " Create vertical split
    vsplit
    " Move to far right
    wincmd L
    " Open target file
    execute 'edit ' . target

    " Go back to status window
    execute "normal! \<C-W>p"
    " Restore status window size
    wincmd J

    if a:isPreview == 0
      " Go back to opened file
      execute "normal! \<C-W>p"
    endif
  else
    echo "No active file to open"
  endif
endfunction

function s:FugitiveDeleteCurrentFile()
  let target = s:FugitiveStatusGetCurrentFile()
  if len(target) > 0
    " Remove file
    call system('git rm -f ' . target)

    " Close buffer
    if bufwinnr(target) > -1
      execute "bdelete " . target
    endif

    " Refresh status window
    execute "normal R"
    echo "Removed " . target
  else
    echoerr "Unable to detect file path at: " . curr_line
  endif
endfunction

function s:FugitiveStatusGetCurrentFile()
  let curr_line = getline('.')
  let tokens = split(curr_line, ' ')
  if len(tokens) == 2
    let file_name = tokens[1]
    return filereadable(file_name) ? file_name : ''
  else
    return ''
  endif
endfunction


augroup fugitive_configs
  autocmd!

  " Auto-cleanup hidden buffers
  autocmd BufReadPost fugitive://* set bufhidden=delete

  " Move to parent commit object
  autocmd User fugitive
    \ if get(b:, 'fugitive_type', '') =~# '^\%(tree\|blob\)$' |
    \   nnoremap <buffer> .. :edit %:h<CR> |
    \ endif
augroup END
