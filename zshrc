# Term Settings
################################################################################

setopt hist_reduce_blanks append_history #share_history
setopt inc_append_history hist_ignore_dups
setopt correct correct_all cdablevars auto_list rec_exact nomatch
setopt long_list_jobs auto_resume 
setopt glob_dots extended_glob rc_quotes mail_warning
setopt auto_cd auto_pushd pushd_minus pushd_to_home pushd_silent

unsetopt bg_nice auto_param_slash beep notify clobber

bindkey  history-incremental-search-backward
bindkey -M vicmd '^r' history-incremental-search-backward

# Exports
################################################################################
setopt   ALL_EXPORT

# mysql
PATH="/usr/local/mysql/bin:/opt/local/bin:/opt/local/sbin:$PATH"
# postgres
PATH="/opt/local/lib/postgresql84/bin/:$PATH"
# general
PATH="$HOME/bin:$HOME/bin/bin:/usr/local/bin:/usr/local/sbin:$PATH"							
# erlang tools
PATH="/Users/nick/Work/Coding/Erlang/elib1/bin:$PATH"


# Make zsh root dir if it doesn't exist
ZSH_ROOT="$HOME/.zsh"
if [ ! -e $ZSH_ROOT ]; then
	mkdir $ZSH_ROOT
fi

HISTFILE="$ZSH_ROOT/history"
HISTSIZE=1000
SAVEHIST=1000

HOSTNAME=`hostname`
PAGER='less'
EDITOR='vim'

# Colors
autoload colors zsh/terminfo

if [[ "$terminfo[colors]" -ge 8 ]]; then
  colors
fi
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
  eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
  eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
    (( count = $count + 1 ))
done
PR_NO_COLOR="%{$terminfo[sgr0]%}"


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

unsetopt ALL_EXPORT

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

# Aliases
################################################################################

if [ `uname` = "Darwin" ]; then # OS X only aliases
	alias ls='ls -Gl '
else # Non OS X aliases
	alias ls='ls -l --color=auto'
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

alias e='mvim --remote'

# Prompts
################################################################################

PROMPT="$PR_CYAN%m:%2c$PR_NO_COLOR %(!.#.$) "

local -A git_res
git_res=`git branch -a --no-color 2> /dev/null`
if [ $? = "0" ]; then
    git_res=`echo $git_res | grep '^*' | tr -d '\* '`
    RPROMPT="%Sgit [$git_res]%s"
fi

typeset -ga precmd_functions

function _rprompt() {
    REP=
    
    # git
    local -A git_res
    git_res=`git branch -a --no-color 2> /dev/null`
    if [ $? = "0" ]; then
        git_res=`echo $git_res | grep '^*' | tr -d '\* '`
        REP="git[$git_res]"
    fi

    # svn
    if [ -d .svn ]; then
        REP="svn"
    fi
    
    RPROMPT="$PR_GREEN $REP $PR_CYAN#%h$PR_NO_COLOR"
}

precmd_functions+=_rprompt
