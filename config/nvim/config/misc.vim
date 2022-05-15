" Show applied highlight groups under cursor
"https://jordanelver.co.uk/blog/2015/05/27/working-with-vim-colorschemes/
nmap <leader>sp :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
