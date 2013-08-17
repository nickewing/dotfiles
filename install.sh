install_dir="$HOME/.dotfiles"
repository="https://github.com/nickewing/dotfiles.git"

################################################################################

function has_command {
  command -v $1 >/dev/null 2>&1;
}

function ensure_dependency_installed {
  if has_command $1; then
    echo "$1 already installed"
  else
    echo "Installing $1"

    if [ `uname` = "Darwin" ]; then
      brew install $1
    else
      sudo apt-get install $1
    fi
  fi
}

function ensure_all_dependencies_installed {
  dependencies="git zsh curl"
  for dependency in $dependencies; do
    ensure_dependency_installed $dependency
  done
}

# install package dependencies
if [ `uname` = "Darwin" ]; then
  if command -v brew >/dev/null 2>&1; then
    echo "brew already installed"
  else
    echo "Installing Homebrew"
    ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
  fi

  ensure_all_dependencies_installed
else
  if command -v apt-get >/dev/null 2>&1; then
    echo "Using apt-get"
    ensure_all_dependencies_installed
  else
    echo "Please install git, zsh and ruby before continuing"
  fi
fi

# install rvm
if has_command rvm; then
  echo "rvm alredy installed"
else
  echo "Installing rvm"
  curl -L https://get.rvm.io | bash
  source "$HOME/.profile"
fi

# install ruby through rvm
if has_command ruby; then
  echo "ruby already installed"
else
  rvm install 1.9.3
  rvm --default 1.9.3
fi

# clone repo
echo "Cloning dotfiles repository"
git clone $repository $install_dir
cd $install_dir

# install rake
if has_command rake; then
  echo "rake already installed"
else
  if ! gem install rake; then
    sudo gem install rake
  fi
fi

# install dotfiles
rake install

# switch to zsh
sudo chsh -s /bin/zsh $USER
/bin/zsh --login
