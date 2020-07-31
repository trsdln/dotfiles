" Triggers ctags reindex for empty file before removal
" so obsolete definitions are removed from ctags
command! RemoveJS execute 'normal!ggdG' | write! | Delete
command! DeleteJS RemoveJS

" Keeping this at ftplugin for JS specifically causes errors
function! s:RenameJS(newName)
  execute 'normal!ggdG'
  write!
  execute 'Rename ' . a:newName
  execute 'normal!u'
  write!
endfunction

command! -nargs=1 RenameJS call s:RenameJS(<f-args>)

function! s:MoveJS(newName)
  execute 'normal!ggdG'
  write!
  execute 'Move ' . a:newName
  execute 'normal!u'
  write!
endfunction

command! -nargs=1 MoveJS call s:MoveJS(<f-args>)
