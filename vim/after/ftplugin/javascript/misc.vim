command! SortJSImportMembers g=\v^import\s?\{$=.+1,/\v^\}\s?from/ sort u | noh

" Configure Ale errors navigation
nmap <buffer> <silent> <C-m> <Plug>(ale_previous_wrap)
nmap <buffer> <silent> <C-n> <Plug>(ale_next_wrap)
