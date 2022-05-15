install_dir="$HOME/.dotfiles"
repository="https://github.com/nickewing/dotfiles.git"

################################################################################

function has_command {
  command -v $1 >/dev/null 2>&1;
}

function check_bin_in_path {
  if has_command $1; then
    echo "$1 already installed"
  else
    echo "Missing $1.  Exiting"
    exit
  fi
}

function ensure_all_packages_installed {
  bin="git ruby rake"

  for package in $bin; do
    check_bin_in_path $package
  done
}

ensure_all_packages_installed

# clone repo
if [ -d $install_dir ]; then
  echo "Pulling origin master in $install_dir"
  cd $install_dir && git pull origin master
else
  echo "Cloning dotfiles repository"
  git clone $repository $install_dir
fi

# install dotfiles
/bin/bash -c "cd $install_dir && rake install"

# switch default shell to zsh
echo "Changing $user's shell to zsh"
sudo chsh -s /bin/zsh $USER
