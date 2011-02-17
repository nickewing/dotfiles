" Setup
" ==============================================================================

set shell=sh

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

" Default encoding
set enc=utf-8

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
set stl+=%=%t\ 

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
set cpoptions=Bces$

" When editing a file, always jump to the last known cursor position.
autocmd BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

" Plug-in Settings
" ==============================================================================

" LaTeX
" =====

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

" Ack command
" ===========

" let g:ackprg = "/opt/local/bin/ack -H --nocolor --nogroup --column "

" XPTemplate
" ==========

" Disable tab highlight
let g:xptemplate_highlight = ''

" Disable brace completion because it doesn't work well
let g:xptemplate_brace_complete = ''

" Set trigger key to tab
let g:xptemplate_key = '<Tab>'

" NERDcommenter
" =============

" Add a space before comments
let NERDSpaceDelims = 1
" Comment all the lines selected
let NERDBlockComIgnoreEmpty = 0
" Disable default mappings
let NERDCreateDefaultMappings = 0

vmap <silent> <D-/> :call NERDComment(1, "toggle")<CR>
nmap <silent> <D-/> :call NERDComment(0, "toggle")<CR>

" vmap <silent> <D-M-/> :call NERDComment(1, "uncomment")<CR>
" nmap <silent> <D-M-/> :call NERDComment(0, "uncomment")<CR>

" NERDTree
" ========

noremap <silent> <Leader>n :NERDTreeToggle<CR>

" Command-t plugin
" ================

" Set the maximum height of completion window
let g:CommandTMaxHeight = 10

function! CommandTFresh()
  execute "CommandTFlush"
  execute "CommandT"
endfunction

nmap <silent> <Leader>f :CommandT<CR>
nmap <silent> <Leader>F :call CommandTFresh()<CR>

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
  " set fuoptions=maxvert,maxhorz
  " au GUIEnter * set fullscreen
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

nmap <silent> <Leader>cc :call BufDelKeepWindow()<CR>

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

function! SaveAndEdit(file)
  let f = a:file
  execute "w " . f
  execute "e! " . f
endfunction
command! -n=1 -complete=file -bar SaveAndEdit :call SaveAndEdit('<args>')

" Custom File Types
" ==============================================================================

au BufNewFile,BufRead *.lfjs set filetype=lisp
au BufRead,BufNewFile *.hamljs set filetype=haml

" General Key Bindings
" ==============================================================================

" Maps to make handling windows a bit easier
map <silent> <Leader>o :wincmd o<CR>
map <silent> <Leader>h :wincmd h<CR>
map <silent> <Leader>j :wincmd j<CR>
map <silent> <Leader>k :wincmd k<CR>
map <silent> <Leader>l :wincmd l<CR>
map <silent> <Leader>sb :wincmd p<CR>
map <silent> <C-h> :vertical resize -10<CR>
map <silent> <C-l> :vertical resize +10<CR>
map <silent> <C-j> :resize +10<CR>
map <silent> <C-k> :resize -10<CR>
map <silent> <Leader>cj :wincmd j<CR>:close<CR>
map <silent> <Leader>ck :wincmd k<CR>:close<CR>
map <silent> <Leader>ch :wincmd h<CR>:close<CR>
map <silent> <Leader>cl :wincmd l<CR>:close<CR>
" map <silent> <Leader>cc :close<CR>
map <silent> <Leader>cw :cclose<CR>
map <silent> <Leader>ml <C-W>L
map <silent> <Leader>mk <C-W>K
map <silent> <Leader>mh <C-W>H
map <silent> <Leader>mj <C-W>J

" Resize frame
noremap <silent> <C-Left> :set columns-=10<CR>
noremap <silent> <C-Right> :set columns+=10<CR>
noremap <silent> <C-Up> :set lines-=10<CR>
noremap <silent> <C-Down> :set lines+=10<CR>

" Remap Q to format instead of Ex mode
map Q gq

" Clear search
nnoremap <silent><CR> :noh<CR><CR>

" TextMate style indention commands
nmap <D-[> <<
nmap <D-]> >>
vmap <D-[> <gv
vmap <D-]> >gv

" Additional movement in normal mode when hjkl aren't available
map <C-F> <Right>
map <C-B> <Left>


