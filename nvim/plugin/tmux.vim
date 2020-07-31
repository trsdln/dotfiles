let s:SERVERS_SESSION = 'servers'
let s:SERVERS_SESSION_WINDOW = s:SERVERS_SESSION . ':1'
let s:SERVERS_SESSION_PANE = s:SERVERS_SESSION_WINDOW . '.1'

nnoremap <leader>jj :TmuxMainReplScrollUp<CR>

command TmuxMainReplScrollUp call s:TmuxMainReplScrollUp()

function! s:TmuxSelectPrimaryPaneAndExecute(commandToExecute)
  let l:sendTmuxPaneCommand =
        \ 'tmux select-window -t ' . s:SERVERS_SESSION_WINDOW
        \ . '\; select-pane -t ' . s:SERVERS_SESSION_PANE
        \ . '\; ' . a:commandToExecute

  call system(l:sendTmuxPaneCommand)
endfunction

function! g:TmuxRunShellCommandAtMainPane(shellCommand)
  let l:sendCommandToPrimaryPaneStr = 'send-keys -t ' . s:SERVERS_SESSION_PANE
        \ . ' C-c && tmux send-keys -t ' . s:SERVERS_SESSION_PANE . ' "' . a:shellCommand . '" C-m'

  call s:TmuxSelectPrimaryPaneAndExecute(l:sendCommandToPrimaryPaneStr)
endfunction

function! s:TmuxMainReplScrollUp()
  let l:sendCommandToPrimaryPaneStr = 'copy-mode -u -t ' . s:SERVERS_SESSION_PANE
  call s:TmuxSelectPrimaryPaneAndExecute(l:sendCommandToPrimaryPaneStr)
endfunction

