setopt ALL_EXPORT

if [[ $COLORTERM == "gnome-terminal" ]]; then
  TERM=xterm-256color
fi

HOSTNAME=`hostname`
PAGER='less'

if [ `uname` = "Darwin" ]; then # OS X specific
  EDITOR='vim'
  GUI_EDITOR='vimr -n'
  GUI_DIFF_TOOL='opendiff'
else
  EDITOR='nvim'
  # GUI_EDITOR='2>/dev/null 1>&2 nvim-qt'
  GUI_EDITOR='nvim-gtk'
  # GUI_DIFF_TOOL='meld'
fi

FZF_DEFAULT_OPTS="--bind=ctrl-n:down,ctrl-p:up,ctrl-j:next-history,ctrl-k:previous-history,ctrl-a:select-all,ctrl-alt-n:preview-up,ctrl-alt-p:preview-down"

unsetopt ALL_EXPORT
