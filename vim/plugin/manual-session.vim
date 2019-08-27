if !exists('g:session_store_dir')
  let g:session_store_dir = '~/.vim/sessions_store'
endif

set sessionoptions=curdir,winpos,buffers,winsize,help,tabpages

nnoremap <leader>ss :SessionSave<CR>
nnoremap <leader>so :SessionOpenDefault<CR>
nnoremap <leader>sco :SessionOpenCustom<CR>
nnoremap <leader>scs :SessionSaveCustom<CR>
nnoremap <leader>scd :SessionDelete<CR>

command! SessionSave call s:SessionUpdateDefault()
command! SessionSaveCustom call s:SessionUpdateCustom()
command! SessionOpenDefault call s:SessionRestoreDefault()
command! SessionOpenCustom call s:SessionRestoreCustom()
command! SessionDelete call s:SessionDelete()


function! s:SessionRestoreCustom()
  call s:PickSessionNameWithFZF('Session', '', function('s:SessionRestoreByOption'))
endfunction

function! s:SessionRestoreByOption(option)
  let file_name = s:GetSessionNameByListItem(a:option)
  call s:SessionRestoreByName(file_name)
endfunction

function! s:SessionUpdateCustom()
  let tag = input('Enter session tag: ')
  " Prevent cluttering of session stored message
  echo "\n"
  let session_file = s:GetSessionFileNameWithTag(tag)
  call s:SessionUpdateByName(session_file)
endfunction

function! s:SessionRestoreDefault()
  call s:SessionRestoreByName(s:GetDefaultSessionFileName())
endfunction

function! s:SessionUpdateDefault()
  call s:SessionUpdateByName(s:GetDefaultSessionFileName())
endfunction

function! s:SessionDelete()
  call s:PickSessionNameWithFZF(
        \ 'Delete Session',
        \ '--multi',
        \ function('s:SessionDeleteByOption'))
endfunction

function! s:SessionDeleteByOption(option)
  let file_name = s:GetSessionNameByListItem(a:option)
  let escaped_file_name = shellescape(file_name)
  let delete_command = 'cd ' . g:session_store_dir . ' && rm -f ' . escaped_file_name
  call system(delete_command)
  echom "Deleted session " . file_name
endfunction


" Session name generation logic

function! s:GetDefaultSessionFileName()
  return s:GetSessionFileNameWithTag('')
endfunction

function! s:GetSessionFileNameWithTag(tag)
  let cwd               = getcwd()
  let branch_name       = system('git symbolic-ref HEAD 2>/dev/null')
  let tag_part          = len(a:tag) == 0 ? '' : '[' . a:tag . ']'
  let raw_session_file  = cwd . '_' . branch_name . tag_part
  let session_file      = substitute(raw_session_file, '[:\\/\r\n]', '%', 'g')  . '.vim'
  return session_file
endfunction


" UI / FZF Picker

function! s:PickSessionNameWithFZF(prompt, flags, on_option_select)
  let raw_names_list = system('ls -1 ' . g:session_store_dir)

  let names_list = map(
        \ split(raw_names_list, '\n'),
        \ 's:GetListItemBySessionName(v:val)')

  " fzf#wrap applies user settings defined at vim/plugins/fzf.vim
  call fzf#run(fzf#wrap({
   \ 'down': '~40%',
   \ 'options': '--prompt "' . a:prompt . '> " ' . a:flags,
   \ 'sink': a:on_option_select,
   \ 'source': names_list }))
endfunction

function! s:GetListItemBySessionName(session_name)
  let decoded_name = substitute(a:session_name, '[:%]', '/', 'g')
  let tag = matchstr(decoded_name, '\v\[\zs.+\ze\]\.vim$')
  let cwd = matchstr(decoded_name, '\v^\zs.+\ze_refs/heads/')
  let branch = matchstr(decoded_name, '\v.+_refs/heads/\zs.+\ze/')
  let formatted_tag = tag == '' ? '[default]' : tag

  " last modification time & date
  let session_file_name = s:GetSessionPathForFile(a:session_name)
  let time = getftime(session_file_name)
  let formatted_time = strftime('%H:%M %a %d-%b %Y', time)

  return printf('%-10s  %-40s  %-40s %-20s <%s>',
        \ formatted_tag, branch, cwd, formatted_time, a:session_name)
endfunction

function! s:GetSessionNameByListItem(list_item)
  return matchstr(a:list_item, '\v\<\zs.+\ze\>')
endfunction

function! s:NoOp(item)
endfunction


" Core Logic
" Based on https://github.com/powerman/vim-plugin-autosess

function! s:SessionRestoreByName(session_file)
  if s:IsModified()
    echoerr 'Some files are modified, please save (or undo) them first'
    return
  endif

  let this_session = s:GetSessionPathForFile(a:session_file)

  " Delete all existing buffers
  bufdo bdelete

  if filereadable(this_session)
   augroup AutosessSwap
      autocmd!
      " 1. If 'swap file already exists' situation happens while restoring
      " session, then Vim will hang and must be killed with `kill -9`. Looks
      " like Vim bug, bug report was sent.
      autocmd SwapExists *       call s:SwapExists()
      " 2. Trying to open such file as 'Read-Only' will fail because previous
      " &readonly value will be restored from session data.
      autocmd SessionLoadPost *  call s:FailIfSwapExists()
    augroup END

    silent execute 'source ' . fnameescape(this_session)

    " 3. Buffers with &buftype 'quickfix' or 'nofile' will be restored empty,
    " so we can get rid of them here to avoid doing this manually each time.
    for bufnr in filter(range(1,bufnr('$')), 'getbufvar(v:val,"&buftype")!~"^$\\|help"')
      execute bufnr . 'bwipeout!'
    endfor
    echo "Session restored"
  endif
endfunction


function! s:SessionUpdateByName(session_file)
  let this_session = s:GetSessionPathForFile(a:session_file)
  if !isdirectory(expand(g:session_store_dir))
    call mkdir(expand(g:session_store_dir), 'p', 0700)
  endif

  if @% == '' && tabpagenr('$') == 1 && winnr('$') == 1 && line('$') == 1 && col('$') == 1
    call delete(this_session)
  elseif tabpagenr('$') >= 1 || (s:WinNr() >= 1 && !&diff)
    execute 'mksession! ' . fnameescape(this_session)
    echo "Session stored"
  elseif winnr('$') == 1 && line('$') == 1 && col('$') == 1
    call delete(this_session)
  endif
endfunction


function! s:GetSessionPathForFile(session_file)
  return expand(g:session_store_dir) . '/' . a:session_file
endfunction


" Utilities

function! s:IsModified()
  for i in range(1, bufnr('$'))
    if bufexists(i) && getbufvar(i, '&modified')
      return 1
    endif
  endfor
  return 0
endfunction

function! s:WinNr()
  let winnr = 0
  for i in range(1, winnr('$'))
    let ft = getwinvar(i, '&ft')
    if ft != 'qf'
      let winnr += 1
    endif
  endfor
  return winnr
endfunction

function! s:SwapExists()
  let s:swapname  = v:swapname
  let v:swapchoice = 'o'
endfunction

function! s:FailIfSwapExists()
  if exists('s:swapname')
    echoerr 'Swap file "'.s:swapname.'" already exists!' 'Autosess: failed to restore session, exiting.'
    qa!
  endif
endfunction
