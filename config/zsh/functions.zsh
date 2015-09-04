
function tn() {
  terminal-notifier -message $1 -activate com.googlecode.iterm2 -group terminal-notify
}

function notify() {
  if [ $? -eq 0 ]; then
    tn "Success!" > /dev/null
    say "Success!"
  else
    tn "Failed!" > /dev/null
    say "Failed!"
  fi

  terminal-notifier -remove terminal-notify > /dev/null
}

function ag_replace() {
  ag -l $1 | xargs perl -pi -E "s/$1/$2/g"
}
