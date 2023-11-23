setopt ALL_EXPORT

ZSH_THEME="nickewing"

if [[ $COLORTERM == "gnome-terminal" ]]; then
  TERM=xterm-256color
fi

HOSTNAME=`hostname`
PAGER='less'

alias neovide='/Applications/Neovide.app/Contents/MacOS/neovide'

if [ `uname` = "Darwin" ]; then # OS X specific
  EDITOR='nvim'
  GUI_EDITOR='neovide'
  GUI_DIFF_TOOL='opendiff'
else
  EDITOR='nvim'
  # GUI_EDITOR='2>/dev/null 1>&2 nvim-qt'
  GUI_EDITOR='nvim-gtk'
  # GUI_DIFF_TOOL='meld'
fi

HISTSIZE=999999999
SAVEHIST=$HISTSIZE

FZF_DEFAULT_OPTS="--bind=ctrl-n:down,ctrl-p:up,ctrl-j:next-history,ctrl-k:previous-history,ctrl-a:select-all,ctrl-alt-n:preview-up,ctrl-alt-p:preview-down"
FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --theme TwoDark --color=always --line-range :500 {}'"

BAT_CONFIG_PATH="$HOME/.bat"

# if [[ -d "$HOME/opt/bin" ]]; then
#   PATH="$HOME/opt/bin:$PATH"
# fi

# if [[ -d "$HOME/bin" ]]; then
#   PATH="$HOME/bin:$PATH"
# fi

unsetopt ALL_EXPORT

if [[ -f "$HOME/.zshrc.local" ]]; then
  source $HOME/.zshrc.local
fi

if command -v direnv &>/dev/null; then
  eval "$(direnv hook zsh)"
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
