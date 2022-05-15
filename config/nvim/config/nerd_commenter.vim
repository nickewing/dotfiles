" Add a space before comments
let NERDSpaceDelims = 1
" Comment all the lines selected
let NERDBlockComIgnoreEmpty = 0
" Disable default mappings
let NERDCreateDefaultMappings = 0

vmap <silent> <leader>c :call NERDComment(1, "toggle")<CR>
nmap <silent> <leader>c :call NERDComment(0, "toggle")<CR>
