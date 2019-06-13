function! s:Gitlab_fugitive_handler(opts, ...)
    let path   = substitute(get(a:opts, 'path', ''), '^/', '', '')
    let line1  = get(a:opts, 'line1')
    let line2  = get(a:opts, 'line2')
    let remote = get(a:opts, 'remote')

    let root = s:Gitlab_homepage_for_remote(remote)
    if empty(root)
        return ''
    endif

    " work out what branch/commit/tag/etc we're on
    " if file is a git/ref, we can go to a /commits gitlab url
    " If the branch/tag doesn't exist upstream, the URL won't be valid
    " Could check upstream refs?
    if path =~# '^\.git/refs/heads/'
        return root . '/commits/' . path[16:-1]
    elseif path =~# '^\.git/refs/tags/'
        return root . '/tags/' . path[15:-1]
    elseif path =~# '^\.git/refs/.'
        return root . '/commits/' . path[10:-1]
    elseif path =~# '^\.git\>'
        return root
    endif

    " Work out the commit
    if a:opts.commit =~# '^\d\=$'
        let commit = a:opts.repo.rev_parse('HEAD')
    else
        let commit = a:opts.commit
    endif

    " If buffer contains directory not file, return a /tree url
    let path = get(a:opts, 'path', '')
    if get(a:opts, 'type', '') ==# 'tree' || path =~# '/$'
        let url = substitute(root . '/tree/' . commit . '/' . path,'/$','', '')
    elseif get(a:opts, 'type', '') ==# 'blob' || path =~# '[^/]$'
        let url = root . "/blob/" . commit . '/' . path
        if line2 && line1 == line2
            let url .= '#L'.line1
        elseif line2
            let url .= '#L' . line1 . '-' . line2
        endif
    else
        let url = root . '/commit/' . commit
    endif

    return url
endfunction

function! s:Gitlab_homepage_for_remote(remote) abort
    let domains = exists('g:fugitive_gitlab_domains') ? g:fugitive_gitlab_domains : []
    call map(domains, 'substitute(v:val, "/$", "", "")')
    let domain_pattern = 'gitlab\.com'
    let rel_paths = {'gitlab.com': 'https://gitlab.com'}
    for domain in domains
        let pattern = split(domain, '://')[-1]
        " as per issue #8 gitlab hosting may have a relative path,
        " but that won't appear in the remote
        let pattern = substitute(pattern, '\v/.*', '', '')
        let rel_paths[pattern] = domain
        let domain_pattern .= '\|' . escape(pattern, '.')
    endfor

    if !exists('g:fugitive_gitlab_ssh_user')
        let g:fugitive_gitlab_ssh_user = 'git'
    endif

    " git://domain:path
    " https://domain/path
    " https://user@domain/path
    " ssh://git@domain/path.git
    " ssh://gitlab@domain/path.git
    " ssh://git@domain:ssh_port/path.git
    let base = matchstr(a:remote, '^\%(https\=://\|git://\|' . g:fugitive_gitlab_ssh_user . '@\|ssh://' . g:fugitive_gitlab_ssh_user . '@\)\%(.\{-\}@\)\=\zs\('.domain_pattern.'\)[/:].\{-\}\ze\%(\.git\)\=$')

    " Remove port
    let base = substitute(base, ':\d\{1,5}\/', '/', '')

    let base = tr(base, ':', '/')
    let domain = substitute(base, '\v/.*', '', '')

    let root = get(rel_paths, domain)
    if empty(root)
        return ''
    endif

    return substitute(base, '^'.domain, root, '')
endfunction

if !exists('g:fugitive_browse_handlers')
    let g:fugitive_browse_handlers = []
endif

if index(g:fugitive_browse_handlers, function('s:Gitlab_fugitive_handler')) < 0
    call insert(g:fugitive_browse_handlers, function('s:Gitlab_fugitive_handler'))
endif
