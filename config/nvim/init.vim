source $HOME/.config/nvim/config/base.vim
source $HOME/.config/nvim/config/plugins.vim

" HACK: Always load ginit.vim to reduce flash of unstyled vim in some GUIs.
" This is clearly not ideal, but works ok with the current configt

" GNvim does not load ginit.vim by default
" if exists("g:gnvim")
  source $HOME/.config/nvim/ginit.vim
" endif

source $HOME/.config/nvim/config/ack.vim
source $HOME/.config/nvim/config/airline.vim
source $HOME/.config/nvim/config/ale.vim
source $HOME/.config/nvim/config/color_column.vim
source $HOME/.config/nvim/config/completion.vim
source $HOME/.config/nvim/config/extra_whitespace.vim
source $HOME/.config/nvim/config/file_types.vim
source $HOME/.config/nvim/config/fzf.vim
source $HOME/.config/nvim/config/line_numbers.vim
source $HOME/.config/nvim/config/mappings.vim
source $HOME/.config/nvim/config/mappings_system.vim
source $HOME/.config/nvim/config/misc.vim
source $HOME/.config/nvim/config/nerd_commenter.vim
source $HOME/.config/nvim/config/nerd_tree.vim
source $HOME/.config/nvim/config/startify.vim
