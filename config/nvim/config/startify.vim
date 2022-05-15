let g:startify_change_to_dir = 0
let g:startify_change_to_vcs_root = 1

let g:startify_bookmarks = [
  \ '~/Work/t40b-r',
  \ '~/Work/t40b-u',
  \ '~/Work/par8o',
  \ '~/.config/nvim',
  \ '~/.dotfiles'
  \ ]

" returns all modified files of the current git repo
" `2>/dev/null` makes the command fail quietly, so that when we are not
" in a git repo, the list will be empty
function! s:gitModified()
    let files = systemlist('git ls-files -m 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

" same as above, but show untracked files, honouring .gitignore
function! s:gitUntracked()
    let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

let g:startify_lists = [
        \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
        \ { 'type': 'sessions',  'header': ['   Sessions']       },
        \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
        \ { 'type': function('s:gitModified'),  'header': ['   git modified']},
        \ { 'type': function('s:gitUntracked'), 'header': ['   git untracked']},
        \ { 'type': 'commands',  'header': ['   Commands']       },
        \ ]

let g:startify_custom_header = [
        \ '   ________   ___      ___ ___  _____ ______',
        \ '  |\   ___  \|\  \    /  /|\  \|\   _ \  _   \',
        \ '  \ \  \\ \  \ \  \  /  / | \  \ \  \\\__\ \  \',
        \ '   \ \  \\ \  \ \  \/  / / \ \  \ \  \\|__| \  \',
        \ '    \ \  \\ \  \ \    / /   \ \  \ \  \    \ \  \',
        \ '     \ \__\\ \__\ \__/ /     \ \__\ \__\    \ \__\',
        \ '      \|__| \|__|\|__|/       \|__|\|__|     \|__|',
        \ ]


function! StartScreen()
  if isdirectory(expand('%:p'))
    Startify
    NERDTreeVCS
    " Switch focus from NERDTree back to Startify
    wincmd w
  else
  endif
endfunction

autocmd VimEnter * :call StartScreen()

" Update NERDTree in case directory changes.  See startify_change_to_vcs_root
autocmd User StartifyBufferOpened NERDTreeVCS | wincmd w | :call StartScreen()
