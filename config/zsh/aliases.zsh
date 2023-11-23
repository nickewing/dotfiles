if [ `uname` = "Darwin" ]; then # OS X specific
	alias ls='ls -Ghl '
else # Non OS X
	alias ls='ls -lh --color=auto'
  alias open='xdg-open'
fi

alias e="$GUI_EDITOR"
alias gui_diff=$GUI_DIFF_TOOL

alias man='LC_ALL=C LANG=C man'
alias pu='pushd '
alias po='popd '

alias where='command -v'
alias get='curl -O '

alias guntar='tar -zxvf'

alias ips='echo "Local:" && ifconfig | grep "inet " | grep -v 127.0.0.1 | cut -d\  -f2 && echo "\nPublic:" && echo `curl -s http://whatismyip.akamai.com/`'

alias -g ..='..'
alias -g ...='../..'
alias -g ....='../../..'

alias ag='ag -S --hidden --ignore-dir .git'

# Git Stuff

alias g='git'
alias -g gr='`git rev-parse --show-cdup`'

# Kubernetes

alias k='kubectl'

# Ruby

alias -g be='bundle exec'
alias -g bi='bundle install'

alias st='spring rake test'
alias sr='spring rspec'
alias sc='spring cucumber'

alias rt='bin/rails test'

# Work

alias rm_orig='find . -name "*.orig" -print0 | xargs -0 rm'
