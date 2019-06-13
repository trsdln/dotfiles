" Interactive Ramda docs
nnoremap <Leader>rd :OpenDocs<cr>
command OpenDocs call s:OpenDocs()

let s:docs_sources_map = {
      \ 'Ramda': 'https://ramdajs.com/docs/#',
      \ 'date-fns': 'https://date-fns.org/v1.30.1/docs/',
      \ 'Fluture': 'https://github.com/fluture-js/Fluture#',
      \ 'recompose': 'https://github.com/acdlite/recompose/blob/master/docs/API.md#',
      \ 'styled-componets': 'https://www.styled-components.com/docs/api#'
      \ }

function! s:OpenDocs()
  let selected_option = s:PickDocsSourceUI()

  if selected_option !=# ''
    let docs_url = get(s:docs_sources_map, selected_option)
    let current_word = expand('<cword>')

    call g:OpenURL(docs_url . shellescape(current_word))
  endif
endfunction

function! s:PickDocsSourceUI()
  let docs_options = keys(s:docs_sources_map)

  " fzf#wrap applies user settings defined at vim/plugins/fzf.vim
  let selected_options = fzf#run(fzf#wrap({
   \ 'down': '~40%',
   \ 'options': '--prompt "Docs>"',
   \ 'sink': function('s:NoOp'),
   \ 'source': docs_options }))

  return len(selected_options) > 0 ? selected_options[0] : ''
endfunction

function! s:NoOp(item)
endfunction
