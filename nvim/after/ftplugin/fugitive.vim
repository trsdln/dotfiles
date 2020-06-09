nnoremap <buffer> cc :Gcommit --no-verify<cr>
nnoremap <buffer> ca :Gcommit --no-verify --amend<cr>
nnoremap <buffer> ce :Gcommit --no-verify --amend --reuse-message=HEAD<cr>
nnoremap <buffer> cvc :tab Gcommit --no-verify --verbose<cr>

" Consistent with Dirvish/Quickfix mappings
" Open at vsplit
nnoremap <buffer> a :call <SID>FugitiveOpenCurrentFileVSplit(0)<cr>
" Preview at vsplit
nnoremap <buffer> ga :call <SID>FugitiveOpenCurrentFileVSplit(1)<cr>

function! s:FugitiveOpenCurrentFileVSplit(isPreview)
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

function! s:FugitiveStatusGetCurrentFile()
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
