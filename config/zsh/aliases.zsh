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

alias -g ..='..'
alias -g ...='../..'
alias -g ....='../../..'

alias ag='ag -S --hidden --ignore-dir .git'

# Git Stuff

alias g='git'
alias -g gr='`git rev-parse --show-cdup`'

# Ruby

alias -g be='bundle exec'
alias -g bi='bundle install'

alias st='spring rake test'
alias sr='spring rspec'
alias sc='spring cucumber'

alias rt='bundle exec ruby -Itest'

# Work

alias rm_orig='find . -name "*.orig" -print0 | xargs -0 rm'

alias repo_update='bundle install && be rake db:migrate db:test:prepare'
alias test_parallel_prepare='be rake parallel:create parallel:prepare'
alias test_parallel='be rake parallel:test; be rake parallel:features; be rake spec; notify'
alias test_all='repo_update && test_parallel_prepare && test_parallel'
