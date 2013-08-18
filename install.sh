install_dir="$HOME/.dotfiles"
repository="https://github.com/nickewing/dotfiles.git"

################################################################################

function has_command {
  command -v $1 >/dev/null 2>&1;
}

function ensure_package_installed {
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

function ensure_all_packages_installed {
  packages="git zsh curl"
  for package in $packages; do
    ensure_package_installed $package
  done
}

function ensure_gem_installed {
  if has_command $1; then
    echo "$2 already installed"
  else
    echo "Installing $2"
    if ! gem install $2; then
      echo "Installing $2 with sudo"
      sudo gem install $2
    fi
  fi
}

# install package dependencies
if [ `uname` = "Darwin" ]; then
  if command -v brew >/dev/null 2>&1; then
    echo "brew already installed"
  else
    echo "Installing Homebrew"
    ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
  fi

  ensure_all_packages_installed
else
  if command -v apt-get >/dev/null 2>&1; then
    ensure_all_packages_installed
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
if [ -d $install_dir ]; then
  echo "Pulling origin master in $install_dir"
  cd $install_dir && git pull origin master
else
  echo "Cloning dotfiles repository"
  git clone $repository $install_dir
fi

# install gems
ensure_gem_installed rake rake
ensure_gem_installed bundle bundler

# install dotfiles
cd $install_dir && rake install

# switch to zsh
sudo chsh -s /bin/zsh $USER
/bin/zsh --login
