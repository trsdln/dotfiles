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
  let l:e2eTestName = matchstr(l:testPath, '\ve2e/\zssrc.+\ze$')

  if l:e2eTestName ==# ''
    let l:commandEnv = ''
  else
    let l:commandEnv = 'E2E=true DEBUG=true USE_MOCK_DATA=false '
  endif

  let l:noExtPath = matchstr(l:testPath, '\v\zs.+\ze\.js$')

  let l:runJestCommand = l:commandEnv . 'yarn jest ' . a:flags . ' --watch ' . l:noExtPath
  call g:TmuxRunShellCommandAtMainPane(l:runJestCommand)
endfunction


" Navigating between test cases
nnoremap <buffer> ]t /\v(\s\|^)\zs(it(\.(only\|skip))?\|beforeEach\|afterEach\|beforeAll\|afterAll)\(/g<cr>:noh<cr>
nnoremap <buffer> [t ?\v(\s\|^)\zs(it(\.(only\|skip)){0,1}\|beforeEach\|afterEach\|beforeAll\|afterAll)\(?g<cr>:noh<cr>

" Toggle test case focus
nnoremap <buffer> <leader>to :<c-u>ToggleTestCaseFocus<cr>

command! ToggleTestCaseFocus call s:ToggleTestCaseFocus()

function! s:ToggleTestCaseFocus()
  try
    " Go to "it" above
    execute 'normal! ?\v(\s|^)(it)(\.only){0,1}\(?g' . "\<cr>"

    " Figure out whether we should add or remove ".only"
    if getline('.') =~# '\v(it)\('
      substitute/\v(\s|^)\zs(it)\ze\(/it.only/
    else
      substitute/\v(\s|^)\zs(it\.only)\ze\(/it/
    endif

    nohlsearch
  catch
    echoerr "No JS test case found!"
  endtry
endfunction
