" Docs Opener (mnemonic: read docs)
nnoremap <buffer> <Leader>rd :OpenDocs<cr>
command! OpenDocs call s:OpenDocs()

let s:docs_sources_map = {
      \ 'Ramda': 'https://ramdajs.com/docs/#',
      \ 'date-fns': 'https://date-fns.org/v1.30.1/docs/',
      \ 'Fluture': 'https://github.com/fluture-js/Fluture#',
      \ 'recompose': 'https://github.com/acdlite/recompose/blob/master/docs/API.md#',
      \ 'styled-componets': 'https://www.styled-components.com/docs/api#'
      \ }

function! s:OpenDocs()
  let docs_options = keys(s:docs_sources_map)

  " fzf#wrap applies user settings defined at vim/plugins/fzf.vim
  call skim#run(skim#wrap({
   \ 'down': '~40%',
   \ 'options': '--prompt "Docs>"',
   \ 'sink': function('s:OpenDocsBySourceName'),
   \ 'source': docs_options }))
endfunction

function! s:OpenDocsBySourceName(selected_option)
  if a:selected_option !=# ''
    let docs_url = get(s:docs_sources_map, a:selected_option)
    let current_word = expand('<cword>')

    call g:XDGOpen(docs_url . shellescape(current_word))
  endif
endfunction
