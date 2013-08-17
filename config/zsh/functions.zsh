
function tn() {
  terminal-notifier -message $1 -activate com.googlecode.iterm2 -group terminal-notify
}

function notify() {
  tn "Alert!" > /dev/null
  say "Alert!"
  terminal-notifier -remove terminal-notify > /dev/null
}
