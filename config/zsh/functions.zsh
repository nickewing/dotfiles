
function tn() {
  terminal-notifier -message $1 -activate com.googlecode.iterm2 -group terminal-notify
}

function notify() {
  if [ $? -eq 0 ]; then
    tn "Erfolg!" > /dev/null
    say "Erfolg!"
  else
    tn "Fehler!" > /dev/null
    say "Fehler!"
  fi

  terminal-notifier -remove terminal-notify > /dev/null
}
