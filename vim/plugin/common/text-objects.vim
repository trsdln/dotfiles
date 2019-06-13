" Text Objects (Credit: Steve Losh) -------------------------------------- {{{

" Shortcut for [] -------------------------------------------------------- {{{

onoremap id i[
onoremap ad a[
vnoremap id i[
vnoremap ad a[

" }}}
" Next/Last () ----------------------------------------------------------- {{{

vnoremap <silent> inb :<C-U>normal! f(vib<CR>
onoremap <silent> inb :<C-U>normal! f(vib<CR>
vnoremap <silent> anb :<C-U>normal! f(vab<CR>
onoremap <silent> anb :<C-U>normal! f(vab<CR>
vnoremap <silent> in( :<C-U>normal! f(vi(<CR>
onoremap <silent> in( :<C-U>normal! f(vi(<CR>
vnoremap <silent> an( :<C-U>normal! f(va(<CR>
onoremap <silent> an( :<C-U>normal! f(va(<CR>

vnoremap <silent> ilb :<C-U>normal! F)vib<CR>
onoremap <silent> ilb :<C-U>normal! F)vib<CR>
vnoremap <silent> alb :<C-U>normal! F)vab<CR>
onoremap <silent> alb :<C-U>normal! F)vab<CR>
vnoremap <silent> il( :<C-U>normal! F)vi(<CR>
onoremap <silent> il( :<C-U>normal! F)vi(<CR>
vnoremap <silent> al( :<C-U>normal! F)va(<CR>
onoremap <silent> al( :<C-U>normal! F)va(<CR>

" }}}
" Next/Last {} ----------------------------------------------------------- {{{

vnoremap <silent> inB :<C-U>normal! f{viB<CR>
onoremap <silent> inB :<C-U>normal! f{viB<CR>
vnoremap <silent> anB :<C-U>normal! f{vaB<CR>
onoremap <silent> anB :<C-U>normal! f{vaB<CR>
vnoremap <silent> in{ :<C-U>normal! f{vi{<CR>
onoremap <silent> in{ :<C-U>normal! f{vi{<CR>
vnoremap <silent> an{ :<C-U>normal! f{va{<CR>
onoremap <silent> an{ :<C-U>normal! f{va{<CR>

vnoremap <silent> ilB :<C-U>normal! F}viB<CR>
onoremap <silent> ilB :<C-U>normal! F}viB<CR>
vnoremap <silent> alB :<C-U>normal! F}vaB<CR>
onoremap <silent> alB :<C-U>normal! F}vaB<CR>
vnoremap <silent> il{ :<C-U>normal! F}vi{<CR>
onoremap <silent> il{ :<C-U>normal! F}vi{<CR>
vnoremap <silent> al{ :<C-U>normal! F}va{<CR>
onoremap <silent> al{ :<C-U>normal! F}va{<CR>

" }}}
" Next/Last [] ----------------------------------------------------------- {{{

vnoremap <silent> ind :<C-U>normal! f[vi[<CR>
onoremap <silent> ind :<C-U>normal! f[vi[<CR>
vnoremap <silent> and :<C-U>normal! f[va[<CR>
onoremap <silent> and :<C-U>normal! f[va[<CR>
vnoremap <silent> in[ :<C-U>normal! f[vi[<CR>
onoremap <silent> in[ :<C-U>normal! f[vi[<CR>
vnoremap <silent> an[ :<C-U>normal! f[va[<CR>
onoremap <silent> an[ :<C-U>normal! f[va[<CR>

vnoremap <silent> ild :<C-U>normal! F]vi[<CR>
onoremap <silent> ild :<C-U>normal! F]vi[<CR>
vnoremap <silent> ald :<C-U>normal! F]va[<CR>
onoremap <silent> ald :<C-U>normal! F]va[<CR>
vnoremap <silent> il[ :<C-U>normal! F]vi[<CR>
onoremap <silent> il[ :<C-U>normal! F]vi[<CR>
vnoremap <silent> al[ :<C-U>normal! F]va[<CR>
onoremap <silent> al[ :<C-U>normal! F]va[<CR>

" }}}
" Next/Last <> ----------------------------------------------------------- {{{

vnoremap <silent> in< :<C-U>normal! f<vi<<CR>
onoremap <silent> in< :<C-U>normal! f<vi<<CR>
vnoremap <silent> an< :<C-U>normal! f<va<<CR>
onoremap <silent> an< :<C-U>normal! f<va<<CR>

vnoremap <silent> il< :<C-U>normal! f>vi<<CR>
onoremap <silent> il< :<C-U>normal! f>vi<<CR>
vnoremap <silent> al< :<C-U>normal! f>va<<CR>
onoremap <silent> al< :<C-U>normal! f>va<<CR>

" }}}
" Next '' ---------------------------------------------------------------- {{{

vnoremap <silent> in' :<C-U>normal! f'vi'<CR>
onoremap <silent> in' :<C-U>normal! f'vi'<CR>
vnoremap <silent> an' :<C-U>normal! f'va'<CR>
onoremap <silent> an' :<C-U>normal! f'va'<CR>

vnoremap <silent> il' :<C-U>normal! F'vi'<CR>
onoremap <silent> il' :<C-U>normal! F'vi'<CR>
vnoremap <silent> al' :<C-U>normal! F'va'<CR>
onoremap <silent> al' :<C-U>normal! F'va'<CR>

" }}}
" Next "" ---------------------------------------------------------------- {{{

vnoremap <silent> in" :<C-U>normal! f"vi"<CR>
onoremap <silent> in" :<C-U>normal! f"vi"<CR>
vnoremap <silent> an" :<C-U>normal! f"va"<CR>
onoremap <silent> an" :<C-U>normal! f"va"<CR>

vnoremap <silent> il" :<C-U>normal! F"vi"<CR>
onoremap <silent> il" :<C-U>normal! F"vi"<CR>
vnoremap <silent> al" :<C-U>normal! F"va"<CR>
onoremap <silent> al" :<C-U>normal! F"va"<CR>

" }}}
