let g:NERDTreeShowHidden=1

let g:NERDTreeMinimalUI=1
let g:NERDTreeMinimalMenu=1

let g:NERDTreeHijackNetrw=0

noremap <silent> <Leader>n :NERDTreeToggle<CR>
noremap <silent> <Leader><Leader> :NERDTreeFind<CR>

" nerdtree-git plugin
let g:NERDTreeGitStatusShowClean = 1
let g:NERDTreeGitStatusUseNerdFonts = 1
let g:NERDTreeGitStatusUntrackedFilesMode = 'all'

" vim-devicons plugin
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
" let g:WebDevIconsNerdTreeAfterGlyphPadding = ' ' 

" Disable default directory listing
let loaded_netrw = 0

" Start NERDTree with Vim
" autocmd VimEnter * NERDTree

" Close NERDTree if it is the only buffer open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
