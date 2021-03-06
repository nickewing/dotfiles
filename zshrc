# Path to your oh-my-zsh configuration.
ZSH=$HOME/.dotfiles/vendor/oh-my-zsh

# Change custom directory path
ZSH_CUSTOM="$HOME/.dotfiles/config/zsh"

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="nickewing"



# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(osx git ruby rvm brew lein knife npm)


source $ZSH/oh-my-zsh.sh

HISTSIZE=999999999
SAVEHIST=$HISTSIZE

# Exports
################################################################################
setopt ALL_EXPORT

# fpath=(/opt/local/share/zsh/4.3.10/functions $fpath)

# reset path
PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"

# personal
if [[ -d "$HOME/opt/bin" ]]; then
  PATH="$HOME/opt/bin:$PATH"
fi

if [[ -d "$HOME/bin" ]]; then
  PATH="$HOME/bin:$PATH"
fi

unsetopt ALL_EXPORT

source $HOME/.dotfiles/vendor/zsh-defer/zsh-defer.plugin.zsh

if [[ -f "$HOME/.zshrc.local" ]]; then
  source $HOME/.zshrc.local
fi
