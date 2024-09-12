if status is-interactive
  alias g git
  alias  gr='cd $(git rev-parse --show-cdup)'

  alias ls="ls -Ghl"
  alias po=prevd
  alias e="neovide --fork"

  alias rt='bin/rails test'
end
