
function ips
  echo "Local:"
  ifconfig | grep "inet " | grep -v 127.0.0.1 | cut -d\  -f2

  echo "Public:"
  curl -s http://whatismyip.akamai.com/ && echo
end
