set brew_bin_path /opt/homebrew/bin/brew

if test -x $brew_bin_path
  eval "$($brew_bin_path shellenv)"
else
  echo "Failed to load homebrew: $brew_bin_path not found or not executable."
end
