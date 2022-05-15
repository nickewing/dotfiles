
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let $FZF_DEFAULT_OPTS = '
  \ --layout=reverse
  \ --info=inline
  \ --bind=ctrl-n:down,
          \ctrl-p:up,
          \ctrl-j:next-history,
          \ctrl-k:previous-history,
          \ctrl-a:select-all,
          \ctrl-alt-p:preview-up,
          \ctrl-alt-n:preview-down'

let $FZF_DEFAULT_COMMAND="rg --files --hidden"

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

let g:fzf_tags_command = 'ctags -R -f .tags'

let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.6, 'yoffset':0.5, 'xoffset': 0.5 } }

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'VertSplit'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

map <leader>f :Files<CR>
map <leader>g :GFiles<CR>
map <leader>s :GFiles?<CR>
map <leader>b :Buffers<CR>
" Trailing spaces here are intentional
" nnoremap <leader>r :Rg 
nnoremap <leader>a :Ag 
nnoremap <leader>t :Tags<CR>
nnoremap <leader>m :Marks<CR>
nnoremap <leader>h :History<CR>
