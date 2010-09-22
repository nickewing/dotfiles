# Term Settings
################################################################################

setopt inc_append_history
setopt hist_ignore_dups hist_ignore_all_dups hist_reduce_blanks

setopt correct correct_all cdablevars auto_list rec_exact nomatch
setopt long_list_jobs auto_resume 
setopt glob_dots extended_glob rc_quotes mail_warning
setopt auto_cd auto_pushd pushd_minus pushd_to_home pushd_silent

unsetopt bg_nice auto_param_slash beep notify clobber

# Exports
################################################################################
setopt   ALL_EXPORT

fpath=(/opt/local/share/zsh/4.3.10/functions $fpath)

# reset path
PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"

# MacPorts
PATH="/opt/local/bin:/opt/local/sbin:$PATH"

# mysql
PATH="/usr/local/mysql/bin:$PATH"

# postgres
PATH="/opt/local/lib/postgresql84/bin/:$PATH"

# personal
PATH="$HOME/bin:$HOME/bin/bin:$PATH"							

# latex
PATH="/usr/local/texlive/2009/bin/universal-darwin:$PATH"

# erlang tools
PATH="$HOME/Work/Coding/Erlang/elib1/bin:$PATH"


# Make zsh root dir if it doesn't exist
ZSH_ROOT="$HOME/.zsh"
if [ ! -e $ZSH_ROOT ]; then
	mkdir $ZSH_ROOT
fi

HISTFILE="$ZSH_ROOT/history"
HISTSIZE=5000
SAVEHIST=5000

HOSTNAME=`hostname`
PAGER='less'
EDITOR='mvim -f'

#TZ="America/New_York"
LC_ALL='en_US.UTF-8'
LANG='en_US.UTF-8'
LC_CTYPE=C
DISPLAY=:0


if [ `uname` = "Darwin" ]; then
  # LS_COLORS from http://journal.mycom.co.jp/column/zsh/010/index.html
  LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
else
  # LSCOLORS: See man ls
  LSCOLORS="exfxcxdxbxegedabagacad"
fi

# RVM
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm

# Clojure REPL
CLOJURE_DIR=$HOME/work/coding/Clojure
CLOJURE_EXT=$CLOJURE_DIR/jline-0.9.94.jar:$CLOJURE_DIR/clojure-1.2.0:$CLOJURE_DIR/clojure-contrib-1.2.0/target
CLOJURE_MAIN="jline.ConsoleRunner clojure.main"

unsetopt ALL_EXPORT

## Bindings
################################################################################

# Use emacs bindings
bindkey -e

bindkey "^P" history-incremental-search-backward
bindkey "^N" history-incremental-search-forward

## Completions
################################################################################

autoload -U compinit
compinit -C

# zstyle ':completion:*:default' menu select=1
# zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
# zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*' menu select=1

# Colors on completion me-ow
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

# Completion caching
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST

# Completion Options
zstyle ':completion:*:match:*' original only
zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:predict:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct
zstyle ':completion:*' completer _complete _prefix _correct _prefix _match _approximate

# Ignore completions for commands that we dont have
zstyle ':completion:*:functions' ignored-patterns '_*'

# Dont complete backups as executables
zstyle ':completion:*:complete:-command-::commands' ignored-patterns '*\~'

# Path Expansion
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-shlashes 'yes'
zstyle ':completion::complete:*' '\\'

# Allow forced showing'
zstyle '*' single-ignored show

# Case insensitivity, partial matching, substitution
zstyle ':completion:*' matcher-list 'm:{A-Z}={a-z}' 'm:{a-z}={A-Z}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'

# Group matches and Describe
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:descriptions' format $'\e[01;33m -- %d --\e[0m'
zstyle ':completion:*:messages' format $'\e[01;35m -- %d --\e[0m'
zstyle ':completion:*:warnings' format $'\e[01;31m -- No Matches Found --\e[0m'

# Prevent re-suggestion
zstyle ':completion:*:rm:*' ignore-line yes
zstyle ':completion:*:scp:*' ignore-line yes
zstyle ':completion:*:ls:*' ignore-line yes

# Menu for KILL
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always

# Kill Menu Extension!
zstyle ':completion:*:processes' command 'ps -U $(whoami) | sed "/ps/d"'
zstyle ':completion:*:processes' insert-ids menu yes select 

compctl -z fg
compctl -j kill
compctl -j disown
compctl -u chown
compctl -u su
compctl -c sudo
compctl -c which
compctl -c type
compctl -c hash
compctl -c unhash
compctl -o setopt
compctl -o unsetopt
compctl -a alias
compctl -a unalias
compctl -A shift
compctl -v export
compctl -v unset
compctl -v echo
compctl -b bindkey

# Show Current Dir as xterm Title
################################################################################

chpwd() {
  [[ -t 1 ]] || return
  case $TERM in
    sun-cmd) print -Pn "\e]l%~\e\\"
      ;;
    *xterm*|rxvt|(dt|k|E)term) print -Pn "\e]2;%~\a"
      ;;
  esac
}

# Prompts
################################################################################

autoload -Uz vcs_info
autoload -U colors && colors

PROMPT="%{$fg[cyan]%}%m:%2c%{$reset_color%} %(!.#.$) "

typeset -ga precmd_functions
 
zstyle ':vcs_info:*' enable git svn

zstyle ':vcs_info:*:*' actionformats ' %s[%b,%r|%a]'
zstyle ':vcs_info:*:*' formats ' %s[%b,%r]'
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%r'

function _rprompt() {
  vcs_info
  
  RPROMPT="%{$fg[green]%} ${vcs_info_msg_0_} %{$fg[cyan]%}#%h%{$reset_color%}"
}

precmd_functions+=_rprompt

# Aliases
################################################################################

if [ `uname` = "Darwin" ]; then # OS X specific 
	alias ls='ls -Ghl '
  alias e='mvim'
  gemacs() {
    /Applications/Emacs.app/Contents/MacOS/Emacs "$@" &
  }
else # Non OS X
	alias ls='ls -lh --color=auto'
fi

alias g='git'

alias man='LC_ALL=C LANG=C man'
alias pu='pushd '
alias po='popd '
alias svn-diff='svn diff --diff-cmd=colordiff | less -RS'

alias where='command -v'
alias get='curl -O '

alias guntar='tar -zxvf'

alias ip='ifconfig | grep "inet " | grep -v 127.0.0.1 | cut -d\  -f2'


alias du='du -sh'

alias -g ..='..'
alias -g ...='../..'
alias -g ....='../../..'

