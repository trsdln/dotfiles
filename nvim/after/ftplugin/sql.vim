command! -nargs=? ExecSQL execute 'Start -wait=always ' .
      \ "echo '\\x \\\\ ' | cat - " . expand('%') .
      \ ' | psql ' . <q-args>
