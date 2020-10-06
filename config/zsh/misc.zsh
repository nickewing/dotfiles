setopt ALL_EXPORT

if [[ $COLORTERM == "gnome-terminal" ]]; then
  TERM=xterm-256color
fi

HOSTNAME=`hostname`
PAGER='less'

if [ `uname` = "Darwin" ]; then # OS X specific
  EDITOR='mvim -v'
else
  EDITOR='vim'
fi

DISPLAY=:0

unsetopt ALL_EXPORT
