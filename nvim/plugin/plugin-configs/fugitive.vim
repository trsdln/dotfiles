" Quick access mappings
noremap <leader>gs :Git<cr>
noremap <leader>gb :MerginalToggle<cr>

" Shortcut push to prevent hooks
call g:SetupCommandAlias("gpu","Git push --no-verify")


function! s:CodeReviewStart(...)
  let s:branch = get(a:, 1, 'origin/develop')
  echo "Code review against " . s:branch

  tabnew
  execute 'Git! difftool --name-status ' . s:branch
  call s:CodeReviewChangeFile('cc')
endfunction

function! s:CodeReviewChangeFile(dir_command)
  try
    execute a:dir_command
    wincmd o
    silent execute 'Gvdiffsplit ' . s:branch . ':%'
  catch
    let err_msg = substitute(v:exception, '\v^Vim\(\w+\):E\d+:\s', "", "")
    echo err_msg
  endtry
endfunction

command! -nargs=? GitCodeReview :call s:CodeReviewStart(<f-args>)

noremap <silent> [d :call <SID>CodeReviewChangeFile('cpfile')<cr>
noremap <silent> ]d :call <SID>CodeReviewChangeFile('cnfile')<cr>
