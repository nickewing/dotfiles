" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  " autocmd VimEnter * PlugInstall
  " autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

	" File tree
	Plug 'preservim/NERDTree'
	Plug 'ryanoasis/vim-devicons'
	Plug 'Xuyuanp/nerdtree-git-plugin'
	Plug 'PhilRunninger/nerdtree-visual-selection'

	" Status Line
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'

	" Tag bar
	Plug 'preservim/tagbar'

	" Start screen
	Plug 'mhinz/vim-startify'

	" Various search facilities
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
	Plug 'mileszs/ack.vim'

	" General editing
	Plug 'tpope/vim-repeat'
	Plug 'tpope/vim-abolish'
	Plug 'bronson/vim-trailing-whitespace'
	" Plug 'jeffkreeftmeijer/vim-numbertoggle'
	Plug 'preservim/nerdcommenter'

	" Git integration
	Plug 'tpope/vim-fugitive'

	" Code checking
	" Plug 'dense-analysis/ale'

	" Themes
	" Plug 'overcache/NeoSolarized'
	Plug 'joshdick/onedark.vim'

	" Language Syntax
	Plug 'sheerun/vim-polyglot'
	Plug 'tpope/vim-rails'
	Plug 'vim-ruby/vim-ruby'
	Plug 'sirtaj/vim-openscad'

call plug#end()
