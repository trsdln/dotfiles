command! -nargs=? ExecSQL execute 'Start -wait=always -title=psql PAGER=less psql --file ' . expand('%') . ' ' . <q-args>
