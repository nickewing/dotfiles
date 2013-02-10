setopt ALL_EXPORT

if [[ $COLORTERM == "gnome-terminal" ]]; then
  TERM=xterm-256color
fi

HOSTNAME=`hostname`
PAGER='less'
EDITOR='vim'

DISPLAY=:0

unsetopt ALL_EXPORT
