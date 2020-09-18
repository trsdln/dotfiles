" Map 'c' to Ramda's compose at vim-surround
let b:surround_99 = "R.compose(\r)"

" JS snippets
call g:ApplySnippetNavigationMapping()

" Unit testing snippets

inoreabbrev <buffer> testd
      \ describe('#', () => {<CR>});
      \<esc>k0f#a
      \<C-R>=g:Eatchar('\s')<CR>

inoreabbrev <buffer> testit
      \ it('should ', () => {<CR>});
      \<esc>k0f';i
      \<C-R>=g:Eatchar('\s')<CR>

inoreabbrev <buffer> testita
      \ it('should ', async () => {<CR>});
      \<esc>k0f';i
      \<C-R>=g:Eatchar('\s')<CR>

" React snippets
inoreabbrev <buffer> rcomp
      \ const  = ({<++>}) => {<CR>  <++><CR>return (<++>);<CR><BS>};
      \<esc>3k0f=hi
      \<C-R>=g:Eatchar('\s')<CR>

inoreabbrev <buffer> rprop
      \ .propTypes = {<CR>  <++><CR><BS>};
      \<esc>2k0i
      \<C-R>=g:Eatchar('\s')<CR>

" Debugging snippets

inoreabbrev <buffer> fdebug
      \ require('poly-utils').fDebug(''),
      \<esc>F'i
      \<C-R>=g:Eatchar('\s')<CR>

inoreabbrev <buffer> fdebugm
      \ R.map(require('poly-utils').fDebug('')),
      \<esc>F'i
      \<C-R>=g:Eatchar('\s')<CR>

inoreabbrev <buffer> finspect
      \ (r) => {<CR>console.log('',deepInspect(r));<CR>return r;<CR><BS>},
      \<esc>2k0f'a
      \<C-R>=g:Eatchar('\s')<CR>

inoreabbrev <buffer> finspectm
      \ R.map((r) => {<CR>console.log('',deepInspect(r));<CR>return r;<CR><BS>}),
      \<esc>2k0f'a
      \<C-R>=g:Eatchar('\s')<CR>

" Import snippets
inoreabbrev <buffer> imprf
      \ import * as R from 'ramda';
      \<CR>import * as F from 'fluture';
      \<CR><esc><bs>

inoreabbrev <buffer> impr
      \ import * as R from 'ramda';
      \<CR><esc><bs>

inoreabbrev <buffer> impf
      \ import * as F from 'fluture';
      \<CR><esc><bs>

inoreabbrev <buffer> imps
      \ import styled from 'styled-components';
      \<CR><esc><bs>

inoreabbrev <buffer> imprt
      \ import React from 'react';
      \<CR><esc><bs>

inoreabbrev <buffer> impc
      \ import {  } from '<++>';
      \<esc>F{la
      \<C-R>=g:Eatchar('\s')<CR>

inoreabbrev <buffer> esexp
      \ // eslint-disable-next-line github/unused-export
      \<C-R>=g:Eatchar('\s')<CR>

inoreabbrev <buffer> esmod
      \ /* eslint-disable github/unused-module */
      \<C-R>=g:Eatchar('\s')<CR>

inoreabbrev <buffer> impd
      \ import  from '<++>';
      \<esc>Ftla
      \<C-R>=g:Eatchar('\s')<CR>

inoreabbrev <buffer> jsd
      \ /**<CR> <CR><C-h><C-h>/
      \<esc>kA<C-h>
      \<C-R>=g:Eatchar('\s')<CR>

