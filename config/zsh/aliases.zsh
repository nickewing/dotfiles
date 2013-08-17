
if [ `uname` = "Darwin" ]; then # OS X specific 
	alias ls='ls -Ghl '
  alias e='mvim'
else # Non OS X
	alias ls='ls -lh --color=auto'
  alias e='gvim'
  alias open='xdg-open'
fi

alias man='LC_ALL=C LANG=C man'
alias pu='pushd '
alias po='popd '
alias svn-diff='svn diff --diff-cmd=colordiff | less -RS'

alias where='command -v'
alias get='curl -O '

alias guntar='tar -zxvf'

alias ip='echo "Local:" && ifconfig | grep "inet " | grep -v 127.0.0.1 | cut -d\  -f2 && echo "\nPublic:" && echo `curl -s http://whatismyip.akamai.com/`'

alias du='du -sh'

alias -g ..='..'
alias -g ...='../..'
alias -g ....='../../..'

# Git Stuff

alias g='git'
alias -g gr='`git rev-parse --show-cdup`'
