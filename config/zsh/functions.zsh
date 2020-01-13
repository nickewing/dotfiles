function ensure_terminal_notifier_installed() {
  if ! [ -x "$(command -v terminal-notifier)" ]; then
    gem install terminal-notifier > /dev/null
  fi
}

function tn() {
  ensure_terminal_notifier_installed

  terminal-notifier -message $1 -activate com.googlecode.iterm2 -group terminal-notify > /dev/null
}

function notify() {
  ensure_terminal_notifier_installed

  if [ $? -eq 0 ]; then
    tn "Success!"
    say "Success!"
  else
    tn "Failed!"
    say "Failed!"
  fi

  terminal-notifier -remove terminal-notify > /dev/null
}

function ag_replace() {
  ag -l $1 | xargs perl -pi -E "s/$1/$2/g"
}
