
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

export LSCOLORS="exfxcxdxbxegedabagacad"
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
