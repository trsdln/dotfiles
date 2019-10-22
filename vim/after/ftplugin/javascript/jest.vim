" Start Jest's tests execution from Vim
nnoremap <buffer> <Leader>jv :StartJest<CR>
nnoremap <buffer> <Leader>jn :StartJestNoVerbose<CR>

command! StartJest call s:StartJestWithFlags('')
command! StartJestNoVerbose call s:StartJestWithFlags('--verbose false')

function! s:StartJestWithFlags(flags)
  " Save file if it isn't saved yet
  update

  let l:testPath = expand('%')

  " Check if E2E test
  let l:e2eTestName = matchstr(l:testPath, '\v^e2e/\zsjest.+\ze$')

  if l:e2eTestName ==# ''
    " Parse test path
    let l:strippedPath = matchstr(l:testPath, '\vpackages/\zs.+\ze\.js$')
    let l:packageName = matchstr(l:strippedPath, '\v\zs[a-z\-]+\ze/.+')
    let l:testName = matchstr(l:strippedPath, '\v[a-z\-]+/\zs.+\ze$')
    let l:commandEnv = ''
  else
    let l:packageName = 'e2e'
    let l:testName = l:e2eTestName
    let l:commandEnv = 'DEBUG=true USE_MOCK_DATA=false'
  endif

  let l:runJestCommand = l:commandEnv . ' yarn test '
        \ . l:packageName
        \ . ' ' . a:flags
        \ . ' --watch ' . l:testName
  call g:TmuxRunShellCommandAtMainPane(l:runJestCommand)
endfunction


" Navigating between test cases
nnoremap <buffer> ]t /\v(\s\|^)\zs(it)(\.(only\|skip))?\(["']/g<cr>:noh<cr>
nnoremap <buffer> [t ?\v(\s\|^)\zs(it)(\.(only\|skip)){0,1}\(["']?g<cr>:noh<cr>

" Toggle test case focus
nnoremap <buffer> <leader>to :<c-u>ToggleTestCaseFocus<cr>

command! ToggleTestCaseFocus call s:ToggleTestCaseFocus()

function! s:ToggleTestCaseFocus()
  try
    " Go to "it" above
    execute 'normal! ?\v(\s|^)(it)(\.only){0,1}\(["'']?g' . "\<cr>"

    " Figure out whether we should add or remove ".only"
    if getline('.') =~# '\v(it)\(["'']'
      substitute/\v(\s|^)\zs(it)\ze\(["']/it.only/
    else
      substitute/\v(\s|^)\zs(it\.only)\ze\(["']/it/
    endif

    nohlsearch
  catch
    echoerr "No JS test case found!"
  endtry
endfunction
