set title                         " Show title in console title bar
set fillchars=""                  " Get rid of the silly characters in window separators
set scrolloff=8                   " keep the cursor 8 lines from the top or bottom of buffer
set number                        " Show line numbers
set cursorline                    " Highlight current line
" set virtualedit=all             " Allow cursor to move to any where
set history=1000                  " Remember some commands
set autoread                      " Auto read outside changes
" set ttyfast                     " Smoother changes
set nohidden                      " Disallow buffers to be put in the background without asking for a save
set noerrorbells visualbell t_vb= " Disable beeps and flashes

set noswapfile                    " Disable swap files
set nobackup nowritebackup        " Disable backup files

if has('cmdline_info')
  set ruler                       " Show status bar
  set showcmd                     " Show partial command being typed in status bar
end

" Search
set hlsearch                      " Highlight all search matches at once
set ignorecase                    " Ignore case when searching
set smartcase                     " Recognize capital letters as case sensitive
set incsearch                     " Search options
set wrapscan                      " Wrap search around document

set signcolumn=yes

" Command line completion
set wildmenu
set wildmode=list:longest
set wildignore+=*.beam,*.o,.git,.svn,*.obj,*.jpg,*.jpeg,*.png,*.gif,*.swf
set wildignore+=.DS_Store,*.amf,*.tiff,*.tif,*.ttf,*.class,*.jar

" Set terminal to 256 colors
" set t_Co=256

set showmatch     " Show matching parens
set nowrap        " Disable line wrapping
" set textwidth=120 " Hard wrap
set textwidth=120 " Hard wrap

set spell         " Turn on spell checking

" Indention options
set autoindent
set smartindent

" 2 character soft tabs
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

" Always allow backspacing
set backspace=indent,eol,start

" Set format options to auto wrap text and understand numbering
set formatoptions=tcqn

" Make the 'cw' and like commands put a $ at the end instead of just deleting
" the text and replacing it
set cpoptions=Bces$

 " Assume a dark background
set background=dark

" Use .tags file
set tags+=.tags

" Ignore tags in completion menu
set cpt-=t

" Enable mouse in all modes
set mouse=a

" Leader key
let mapleader = ","

" When editing a file, always jump to the last known cursor position.
autocmd BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

" Disable spell check in quickfix panel
autocmd FileType qf setlocal nospell

