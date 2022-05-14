" Load Vundle Bundles
" ==============================================================================

set nocompatible
filetype off

set shell=/bin/bash

set rtp+=~/.dotfiles/vendor/vim/vundle
call vundle#begin(expand("~/.dotfiles/vendor/vim"))

Plugin 'VundleVim/Vundle.vim'

source ~/.dotfiles/config/vim/bundles.vim

call vundle#end()
filetype plugin indent on

" " let g:bundle_names = map(copy(g:bundles), 'v:val.name')
" function! HasBundle(name)
"   "return index(g:bundle_names, a:name) != -1
" 
"   return has_key(g:bundle_names, a:name)
" endfunction

set rtp+=~/.dotfiles/config/vim

" General
" ==============================================================================


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

" if has('statusline') && !HasBundle('vim-powerline')
  set laststatus=2

  " Broken down into easily includeable segments
  set statusline=%<%f\    " Filename
  set statusline+=%w%h%m%r " Options
  " if HasBundle('vim-fugitive')
    set statusline+=%{fugitive#statusline()} "  Git Hotness
  " endif
  set statusline+=\ [%{&ff}/%Y]            " filetype
  set statusline+=\ [%{getcwd()}]          " current dir
  set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
" endif

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

" Set terminal to 256 colors
set t_Co=256

" Editing
" ==============================================================================

set showmatch     " Show matching parens
set spell         " Turn on spell checking
set nowrap        " Disable line wrapping
set textwidth=120 " Hard wrap

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
if filereadable(expand("~/.dotfiles/vendor/vim/vim-colors-solarized/colors/solarized.vim"))
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
    " set guifont=Fira\ Code:h12
    " set guifont=Hasklig:h12
    set macligatures
  end

  if has('gui_macvim')
    set transparency=5          " Make the window slightly transparent
  endif

  set colorcolumn=121
  let &colorcolumn=join(range(121,999),",")
end

" Omnicomplete
" ==============================================================================

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

" Disable ex mode
map Q <Nop>

" Plug-ins
" ==============================================================================

" NERDTree
" ========

" if HasBundle('nerdtree')
  let NERDTreeShowHidden=1

  noremap <silent> <Leader>n :NERDTreeToggle<CR>
  noremap <silent> <Leader><Leader> :NERDTreeFind<CR>
" endif

" NERDcommenter
" =============

" if HasBundle('nerdcommenter')
  " Add a space before comments
  let NERDSpaceDelims = 1
  " Comment all the lines selected
  let NERDBlockComIgnoreEmpty = 0
  " Disable default mappings
  let NERDCreateDefaultMappings = 0

  vmap <silent> <D-/> :call NERDComment(1, "toggle")<CR>
  nmap <silent> <D-/> :call NERDComment(0, "toggle")<CR>
" endif

" LaTeX
" =====

" if HasBundle('vim-latex')
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
" endif

" Ctrl-P
" ======

" Also see vim/plugin/ctrlp_matcher.vim

" if HasBundle('ctrlp.vim')
  let g:ctrlp_match_window_reversed = 0
  let g:ctrlp_map = '<leader>f'

  " let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist|log|tmp)|(\.(swp|ico|git|svn))$'
  let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --ignore ''.git'' --ignore ''.DS_Store'' --ignore ''node_modules'' --hidden -g ""'
  let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }

  let g:ctrlp_max_files = 0
  " let g:ctrlp_max_depth = 40
  " let g:ctrlp_follow_symlinks=1
  " let g:ctrlp_path_nolim = 1

  nmap <silent> <Leader>b :CtrlPBuffer<CR>

" endif

" Syntastic
" =========

let g:syntastic_enable_signs=1
" let g:syntastic_quiet_messages = {'level': 'warnings'}
let g:syntastic_javascript_checkers = ['eshint']
let g:syntastic_ruby_checkers       = ['rubocop', 'mri']
let g:syntastic_ruby_mri_exec = system("asdf which ruby")

" indent_guides
" =============

" if HasBundle("vim-indent-guides")
  " for some colorscheme, autocolor will not work,like 'desert','ir_black'.
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#212121 ctermbg=3
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#404040 ctermbg=4

  let g:indent_guides_start_level = 2
  let g:indent_guides_guide_size = 1
  let g:indent_guides_enable_on_vim_startup = 1
" endif

" Custom File Types
" ==============================================================================
au BufNewFile,BufRead *.lfjs set filetype=lisp
au BufRead,BufNewFile *.hamljs set filetype=haml
au BufRead,BufNewFile *.ypp set filetype=yacc
au! BufRead,BufNewFile *.cljs set filetype=clojure
au BufRead,BufNewFile *.nghtml set filetype=html
au BufNewFile,BufRead *.es6 set filetype=javascript
au BufNewFile,BufRead *.ngrb set filetype=ruby
au BufNewFile,BufRead *.yml.j2 set filetype=yaml
au BufNewFile,BufRead *.yaml.j2 set filetype=yaml
au BufNewFile,BufRead *.envrc set filetype=bash
au BufNewFile,BufRead *.envrc.sample set filetype=bash

" Commands
" ==============================================================================

command! RubyNewHashSyntax :s/:\([^ ]*\)\(\s*\)=>/\1:/g
command! RubyNewHashSyntaxAllFile :%s/:\([^ ]*\)\(\s*\)=>/\1:/g

command -nargs=1 -complete=file E execute('silent! !mkdir -p "$(dirname "<args>")"') <Bar> e <args>

let g:ackprg = 'ag --vimgrep --smart-case'
cnoreabbrev ag Ack
cnoreabbrev aG Ack
cnoreabbrev Ag Ack
cnoreabbrev AG Ack
set grepprg=ag\ --nogroup\ --nocolor


" HTML Indentation settings
" ==============================================================================
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"
let g:html_indent_inctags = "address,article,aside,audio,blockquote,canvas,dd,div,dl,fieldset,figcaption,figure,footer,form,h1,h2,h3,h4,h5,h6,header,hgroup,hr,main,nav,noscript,ol,output,p,pre,section,table,tfoot,ul,video"
