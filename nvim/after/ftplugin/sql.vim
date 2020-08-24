command! -nargs=? ExecSQL execute 'Start -wait=always ' .
      \ 'echo "\\i ' . expand('%') .
      \ '" | psql ' . <q-args>
