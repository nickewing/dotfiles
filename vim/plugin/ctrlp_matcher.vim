"https://github.com/burke/matcher

let g:path_to_matcher = "~/.vim/bundle/matcher/matcher"

let g:ctrlp_user_command = {
  \ 'types': {
    \ 1: ['.git/', 'cd %s && git ls-files'],
    \ },
  \ 'fallback': 'find %s -type f'
  \ }

function! g:GoodMatch(items, str, limit, mmode, ispath, crfile, regex)
  " the Command-T matcher doesn't do regex. Return now if that was requested.
  if a:regex == 1
    let [lines, id] = [[], 0]
    for item in a:items
      let id += 1
      try | if !( a:ispath && item == a:crfile ) && (match(item, a:str) >= 0)
        cal add(lines, item)
      en | cat | brea | endt
    endfo
    return lines
  end

  " a:mmode is currently ignored. In the future, we should probably do
  " something about that. the matcher behaves like "full-line".
  let cmd = g:path_to_matcher . " --limit " . a:limit . " --manifest " . ctrlp#utils#cachefile() . " "
  if ! g:ctrlp_dotfiles
    let cmd = cmd . "--no-dotfiles "
  endif
  let cmd = cmd . a:str
  return split(system(cmd))

endfunction
let g:ctrlp_match_func = { 'match': 'g:GoodMatch' }
