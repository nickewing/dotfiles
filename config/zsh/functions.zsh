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
  ag -l $1 $3 | xargs perl -pi -E "s/$1/$2/g"
}

function kforward() {
  trap 'tput cnorm;' INT TERM

  echo "Forwarding port $3 from $2 in namespace $1"
  nohup kubectl port-forward $2 $3 --namespace $1 </dev/null >/dev/null 2>&1 &
    echo "$!" > /tmp/k8s-port-forward.pid

  sleep 0.5

  echo

  ${@:4}

  echo

  echo "Closing forwarded port"
  kill "$(cat /tmp/k8s-port-forward.pid)" || true
  rm -f /tmp/k8s-port-forward.pid
}

function kbash() {
  kubectl exec -n $1 -it $2 $3 -- /bin/sh
}

# function e() {
  # 2>/dev/null 1>&2 nvim-qt $1 &!
  # gnvim --gtk-prefer-dark-theme $1 &!
  # $GUI_EDITOR $@
# }
