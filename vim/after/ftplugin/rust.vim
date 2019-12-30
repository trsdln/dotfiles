augroup rust_fmt
  autocmd!
  autocmd BufWritePost *.rs execute 'silent !rustfmt %' | edit
augroup END
