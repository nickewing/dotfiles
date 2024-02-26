if test -d /Applications/Neovide.app/Contents/MacOS
  set -gx PATH $PATH /Applications/Neovide.app/Contents/MacOS
else
  echo "Failed to load neovide into path"
end
