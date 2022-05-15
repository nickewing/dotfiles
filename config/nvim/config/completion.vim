" if has("autocmd") && exists("+omnifunc")
  " autocmd Filetype *
        " \if &omnifunc == "" |
        " \setlocal omnifunc=syntaxcomplete#Complete |
        " \endif
" endif

" hi Pmenu  guifg=#000000 guibg=#F8F8F8 ctermfg=black ctermbg=Lightgray
" hi PmenuSbar  guifg=#8A95A7 guibg=#F8F8F8 gui=NONE ctermfg=darkcyan ctermbg=lightgray cterm=NONE
" hi PmenuThumb  guifg=#F8F8F8 guibg=#8A95A7 gui=NONE ctermfg=lightgray ctermbg=darkcyan cterm=NONE

" some convenient mappings
inoremap <expr> <Esc>  pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <expr> <CR>   pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Down> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>   pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <C-d>  pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
inoremap <expr> <C-u>  pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

" automatically open and close the popup menu / preview window
" au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menu,preview,longest

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
