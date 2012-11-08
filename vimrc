" Load Vundle Bundles
" ==============================================================================

filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#rc()

source ~/.dotfiles/config/vim/bundles.vim

let g:bundle_names = map(copy(g:bundles), 'v:val.name')
function! HasBundle(name)
  return index(g:bundle_names, a:name) != -1
endfunction

" General
" ==============================================================================

set nocompatible " Don't worry about vi compatibility

syntax enable " Turn on syntax highlighting
filetype plugin indent on " Allow filetype specific options

" Default encoding
set enc=utf-8
scriptencoding utf-8

set title                         " Show title in console title bar
set fillchars=""                  " Get rid of the silly characters in window separators
set scrolloff=8                   " keep the cursor 8 lines from the top or bottom of buffer
set number                        " Show line numbers
set cursorline                  " Highlight current line
" set virtualedit=all             " Allow cursor to move to any where

set history=1000                  " Remember some commands
set autoread                      " Auto read outside changes
set ttyfast                       " Smoother changes
set nohidden                      " Disallow buffers to be put in the background without asking for a save

set noswapfile                    " Disable swap files
set nobackup nowritebackup        " Disable backup files
set noerrorbells visualbell t_vb= " Disable beeps and flashes

if has('cmdline_info')
  set ruler                         " Show status bar
  set showcmd                       " Show partial command being typed in status bar
end

if has('statusline') && !HasBundle('vim-powerline')
  set laststatus=2

  " Broken down into easily includeable segments
  set statusline=%<%f\    " Filename
  set statusline+=%w%h%m%r " Options
  if HasBundle('vim-fugitive')
    set statusline+=%{fugitive#statusline()} "  Git Hotness
  endif
  set statusline+=\ [%{&ff}/%Y]            " filetype
  set statusline+=\ [%{getcwd()}]          " current dir
  set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
endif

set hlsearch                      " Highlight all search matches at once
set ignorecase                    " Ignore case when searching
set smartcase                     " Recognize capital letters as case sensitive
set incsearch                     " Search options
set wrapscan                      " Wrap search around document

" Show completions menu
set wildmenu
set wildmode=list:longest
set wildignore+=*.beam,*.o,.git,.svn,*.obj,*.jpg,*.jpeg,*.png,*.gif,*.swf
set wildignore+=.DS_Store,*.amf,*.tiff,*.tif,*.ttf,*.class,*.jar

" Persistent undo
if has('persistent_undo')
  set undofile
  set undolevels=1000  " maximum number of changes that can be undone
  set undoreload=10000 " maximum number of lines to save for undo on a buffer reload
endif

" Editing
" ==============================================================================

set showmatch    " Show matching parens
set spell        " Turn on spell checking
set nowrap       " Disable line wrapping
set textwidth=80 " Hard wrap

" Indention options
set autoindent
set smartindent

" 2 character soft tabs
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

" Set format options to auto wrap text and understand numbering
set formatoptions=tcqn

" Make the 'cw' and like commands put a $ at the end instead of just deleting
" the text and replacing it
set cpoptions=Bces$

" When editing a file, always jump to the last known cursor position.
autocmd BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

" Color Scheme
" ==============================================================================

set background=dark     " Assume a dark background
if filereadable(expand("~/.vim/bundle/vim-colors-solarized/colors/solarized.vim"))
  let g:solarized_termcolors=256
  let g:solarized_termtrans=1
  let g:solarized_contrast="high"
  let g:solarized_visibility="high"

  color solarized " load a colorscheme
endif

" GUI
" ==============================================================================

if has("gui_running")
  set guioptions-=rL

  if has("unix") && match(system("uname"),'Darwin') != -1
    set guifont=Monaco:h12
  end

  if has('gui_macvim')
    set transparency=5          " Make the window slightly transparent
  endif
end

" Omnicomplete
" ==============================================================================

if has("autocmd") && exists("+omnifunc")
  autocmd Filetype *
        \if &omnifunc == "" |
        \setlocal omnifunc=syntaxcomplete#Complete |
        \endif
endif

hi Pmenu  guifg=#000000 guibg=#F8F8F8 ctermfg=black ctermbg=Lightgray
hi PmenuSbar  guifg=#8A95A7 guibg=#F8F8F8 gui=NONE ctermfg=darkcyan ctermbg=lightgray cterm=NONE
hi PmenuThumb  guifg=#F8F8F8 guibg=#8A95A7 gui=NONE ctermfg=lightgray ctermbg=darkcyan cterm=NONE

" some convenient mappings
inoremap <expr> <Esc>  pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <expr> <CR>   pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Down> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>   pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <C-d>  pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
inoremap <expr> <C-u>  pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menu,preview,longest

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

" General Key Bindings
" ==============================================================================

" Leader key
let mapleader = ","

" Resize windows
map <silent> <C-h> :vertical resize -10<CR>
map <silent> <C-l> :vertical resize +10<CR>
map <silent> <C-j> :resize +10<CR>
map <silent> <C-k> :resize -10<CR>

" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Plug-ins
" ==============================================================================

" NERDTree
" ========

if HasBundle('nerdtree')
  let NERDTreeShowHidden=1

  noremap <silent> <Leader>n :NERDTreeToggle<CR>
  noremap <silent> <Leader><Leader> :NERDTreeFind<CR>
endif

" NERDcommenter
" =============

if HasBundle('nerdcommenter')
  " Add a space before comments
  let NERDSpaceDelims = 1
  " Comment all the lines selected
  let NERDBlockComIgnoreEmpty = 0
  " Disable default mappings
  let NERDCreateDefaultMappings = 0

  vmap <silent> <D-/> :call NERDComment(1, "toggle")<CR>
  nmap <silent> <D-/> :call NERDComment(0, "toggle")<CR>
endif

" LaTeX
" =====

if HasBundle('vim-latex')
  " View program for OSX
  if has("unix") && match(system("uname"),'Darwin') != -1
    let g:Tex_ViewRule_pdf = 'open -a Skim.app'
  end

  " No default foldings
  let g:Tex_FoldedSections = ''
  let g:Tex_FoldedEnvironments = ''
  let g:Tex_FoldedCommands = ''

  " remap to avoid collision with <C-j> mapping
  imap <C-g> <Plug>IMAP_JumpForward
  nmap <C-g> <Plug>IMAP_JumpForward
endif

" Ctrl-P
" ======

if HasBundle('ctrlp.vim')
  let g:ctrlp_match_window_reversed = 0
  let g:ctrlp_map = '<leader>f'

  " Syntastic syntax checking
  let g:syntastic_enable_signs=1
  let g:syntastic_quiet_warnings=1

  nmap <silent> <Leader>b :CtrlPBuffer<CR>
endif

" neocomplcache
" =============

if HasBundle('neocomplcache')
  let g:neocomplcache_enable_at_startup = 1
  let g:neocomplcache_enable_camel_case_completion = 1
  let g:neocomplcache_enable_smart_case = 1
  let g:neocomplcache_enable_underbar_completion = 1
  let g:neocomplcache_min_syntax_length = 3
  let g:neocomplcache_enable_auto_delimiter = 1
  let g:neocomplcache_max_list = 15
  let g:neocomplcache_auto_completion_start_length = 3
  let g:neocomplcache_force_overwrite_completefunc = 1
  let g:neocomplcache_snippets_dir='~/.vim/bundle/snipmate-snippets/snippets'

  " AutoComplPop like behavior.
  let g:neocomplcache_enable_auto_select = 0

  " SuperTab like snippets behavior.
  imap <silent><expr><tab> neocomplcache#sources#snippets_complete#expandable() ? "\<plug>(neocomplcache_snippets_expand)" : (pumvisible() ? "\<c-e>" : "\<tab>")
  smap <tab> <right><plug>(neocomplcache_snippets_jump) 

  " Plugin key-mappings.
  " Ctrl-k expands snippet & moves to next position
  " <CR> chooses highlighted value
  imap <C-k> <Plug>(neocomplcache_snippets_expand)
  smap <C-k> <Plug>(neocomplcache_snippets_expand)
  inoremap <expr><C-g> neocomplcache#undo_completion()
  inoremap <expr><C-l> neocomplcache#complete_common_string()
  inoremap <expr><CR>  neocomplcache#complete_common_string()

  " <CR>: close popup
  " <s-CR>: close popup and save indent.
  inoremap <expr><s-CR> pumvisible() ? neocomplcache#close_popup()"\<CR>" : "\<CR>"
  inoremap <expr><CR> pumvisible() ? neocomplcache#close_popup() : "\<CR>"

  " <TAB>: completion.
  inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
  inoremap <expr><s-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"

  " <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
  inoremap <expr><C-y> neocomplcache#close_popup()

  " Define keyword.
  if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
  endif
  let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

  " Enable heavy omni completion.
  if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
  endif
  let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
  let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
  let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
  let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

  " For snippet_complete marker.
  if has('conceal')
    set conceallevel=2 concealcursor=i
  endif
endif

" indent_guides
" =============

if HasBundle("vim-indent-guides")
  " for some colorscheme, autocolor will not work,like 'desert','ir_black'.
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#212121 ctermbg=3
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#404040 ctermbg=4

  let g:indent_guides_start_level = 2
  let g:indent_guides_guide_size = 1
  let g:indent_guides_enable_on_vim_startup = 1
endif

" Custom File Types
" ==============================================================================
au BufNewFile,BufRead *.lfjs set filetype=lisp
au BufRead,BufNewFile *.hamljs set filetype=haml
au BufRead,BufNewFile *.ypp set filetype=yacc
au! BufRead,BufNewFile *.cljs set filetype=clojure
