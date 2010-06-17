" Setup
" ==============================================================================

" Add to search path
set path+=~/Work/**

set runtimepath+=~/.vim/personal

" Load all plugin bundles
call pathogen#runtime_append_all_bundles()
" This only needs to happen when new plugs are added
call pathogen#helptags()

" General Settings
" ==============================================================================

" Don't worry about vi compatibility
set nocompatible

" Turn on syntax highlighting
syntax enable

" Allow filetype specific options
filetype on
filetype plugin on
filetype indent on

" Remember some commands
set history=300

" Auto read outside changes
set autoread

" Highlight current line
" set cursorline

" Search options
set incsearch
" Wrap search around document
set wrapscan
" Ignore case when searching
set ignorecase
" Recognize capital letters as case sensitive
set smartcase
" Highlight all search matches at once
set hlsearch

" Show status bar
set ruler

" Left side of status bar
set stl=\ #%n\ %-15(%l/%L,%c%)%-15([%b,0x%B]%)%y%([%R%M]%)%{fugitive#statusline()}
" Right side of status bar"
set stl+=%=%f\ 

" Tell VIM to always put a status line in, even if there is only one window
set laststatus=2

" Allow cursor to move to any where
" set virtualedit=all

" Show title in console title bar
set title
" Smoother changes
set ttyfast

" Show line numbers
set number

" Show the command being typed
set showcmd

" Allow buffers to be put in the background without asking for a save
" set hidden

" Get rid of the silly characters in window separators
set fillchars=""

" Disable sounds on errors
set noerrorbells
set visualbell t_vb=
" Disable visual bells
" set novisualbell

" When the page starts to scroll, keep the cursor 8 lines from the top and 8
" lines from the bottom
set scrolloff=8

" Disable backups
set nobackup
set nowb
set noswapfile

" Show completions menu
set wildmenu
" set wildmode=list:longest
set wildignore+=*.beam,*.o,.git,.svn,*.obj,*.jpg,*.jpeg,*.png,*.gif,*.swf
set wildignore+=.DS_Store,*.amf,*.tiff,*.tif,*.ttf

" Leader key
let mapleader = ","

" Editing Settings
" ==============================================================================

" Show matching parens
set showmatch

" Turn on spell checking
set spell

" Disable line wrapping
set nowrap

" Indention options
set autoindent
set smartindent

" 2 character soft tabs
set expandtab
set tabstop=2
set shiftwidth=2

" Hard wrap
set textwidth=80

" Set format options to auto wrap text and understand numbering
set formatoptions=tcqn

" Make the 'cw' and like commands put a $ at the end instead of just deleting
" the text and replacing it
set cpoptions=ces$

" When editing a file, always jump to the last known cursor position.
autocmd BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

" Plug-in Settings
" ==============================================================================

" Ack command
" ===========

" let g:ackprg = "/opt/local/bin/ack -H --nocolor --nogroup --column "

" XPTemplate
" ==========

" Disable tab highlight
let g:xptemplate_highlight = ''

" NERDcommenter
" =============

" Add a space before comments
let NERDSpaceDelims = 1
" Comment all the lines selected
let NERDBlockComIgnoreEmpty = 0

" NERDTree
" ========

noremap <silent> <Leader>n :NERDTreeToggle<CR>

" Command-t plugin
" ================

" Set the maximum height of completion window
let g:CommandTMaxHeight = 10

nmap <silent> <Leader>f :CommandT<CR>

" FuzzyFinder
" ===========

" Disable preview window
let g:fuf_previewHeight = 0
" Disable recent command menu
let g:fuf_modesDisable = [ 'mrucmd', ]
" Set maximum recent files
let g:fuf_mrufile_maxItem = 50

nmap <silent> <Leader>b :FufBuffer<CR>
nmap <silent> <C-X><C-F> :FufMruFile<CR>

" Taglist
" =======

" Make list smaller
let Tlist_Compact_Format = 1
" Don't highlight current tag while moving through file
let Tlist_Auto_Highlight_Tag = 0
" Hide holding bars
let Tlist_Enable_Fold_Column = 0
" Only show list for current buffer
let Tlist_Show_One_File = 1

nmap <silent> <Leader>i :TlistToggle<CR>

" GUI Settings
" ==============================================================================

if has("gui_running")
  " Hide GUI toolbar
  set guioptions-=T
  " Default to full screen
  set fuoptions=maxvert,maxhorz
  au GUIEnter * set fullscreen
  " Color scheme
  colorscheme railscasts
  " Set transparency
  set transparency=3
  " Set font
  set guifont=DejaVu\ Sans\ Mono:h11
  set guioptions=ce 
  "              ||
  "              |+-- use simple dialogs rather than pop-ups
  "              +  use GUI tabs, not console style tabs
  " Hide mouse while typing
  set mousehide
  " Possibly improve terminal evaluation?
  set guipty
  " Set some default sizes
  set columns=100
  set lines=60
endif

" Useful Functions
" ==============================================================================

function! <SID>StripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

" autocmd BufWritePre *.py,*.js :call <SID>StripTrailingWhitespaces()

" StripTrailingWhitespaces binding
nnoremap <silent> <F5> :call <SID>StripTrailingWhitespaces()<CR>

" delete buffer, keep window
function! BufDelKeepWindow()
  let bufNum = bufnr("%")
  if !getbufvar("%", "&confirm") && getbufvar("%", "&modified")
    let confirmed = confirm("Buffer modified. Continue?", "&Yes\n&No", 2)
    if confirmed != 1
      return
    end
  end

  let winNum = winnr()
  let prevBufNum = bufnr("#")
  if(prevBufNum > 0 && buflisted(prevBufNum) && prevBufNum != bufNum)
    b! #
  else
    bn!
  endif
  execute "bd! " . bufNum
  execute "normal " . winNum
endfunction

map <silent> <Leader>cc :call BufDelKeepWindow()<CR>

function! SetTabNameToCWD()
  let path = split(getcwd(), "/")
  if len(path) > 0
    let name = path[-1]
  else
    let name = '/'
  end
  execute "TName '" . name . "'"
endfunction
command! -n=0 -bar SetTabNameToCWD :call SetTabNameToCWD()

function! DirTab(dir)
  let d = a:dir
  tabnew
  execute "lcd " . d
  call SetTabNameToCWD()
endfunction
command! -n=1 -complete=dir -bar DirTab :call DirTab('<args>')

" General Key Bindings
" ==============================================================================

" Maps to make handling windows a bit easier
noremap <silent> <Leader>o :wincmd o<CR>
noremap <silent> <Leader>h :wincmd h<CR>
noremap <silent> <Leader>j :wincmd j<CR>
noremap <silent> <Leader>k :wincmd k<CR>
noremap <silent> <Leader>l :wincmd l<CR>
noremap <silent> <Leader>sb :wincmd p<CR>
noremap <silent> <C-h> :vertical resize -10<CR>
noremap <silent> <C-j> :resize +10<CR>
noremap <silent> <C-k> :resize -10<CR>
noremap <silent> <C-l> :vertical resize +10<CR>
noremap <silent> <Leader>cj :wincmd j<CR>:close<CR>
noremap <silent> <Leader>ck :wincmd k<CR>:close<CR>
noremap <silent> <Leader>ch :wincmd h<CR>:close<CR>
noremap <silent> <Leader>cl :wincmd l<CR>:close<CR>
" noremap <silent> <Leader>cc :close<CR>
noremap <silent> <Leader>cw :cclose<CR>
noremap <silent> <Leader>ml <C-W>L
noremap <silent> <Leader>mk <C-W>K
noremap <silent> <Leader>mh <C-W>H
noremap <silent> <Leader>mj <C-W>J
noremap <silent> <C-7> <C-W>>
noremap <silent> <C-8> <C-W>+
noremap <silent> <C-9> <C-W>+
noremap <silent> <C-0> <C-W>>

" Resize frame
map <silent> <C-H> :set columns-=10<CR>
map <silent> <C-L> :set columns+=10<CR>
map <silent> <C-K> :set lines-=10<CR>
map <silent> <C-J> :set lines+=10<CR>

" Remap Q to format instead of Ex mode
map Q gq

" Clear search
nnoremap <silent><CR> :noh<CR><CR>

" TextMate style indention commands
nmap <D-[> <<
nmap <D-]> >>
vmap <D-[> <gv
vmap <D-]> >gv

