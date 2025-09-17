alias -- -="cd -"

alias \
  ...="cd ../.." \
  nhos="nh os switch" \
  nhh="nh home switch" \
  lg="lazygit" \
  arttime="arttime --nolearn --style 1 --pa  --pb  --pl 20"

# nix develop with zsh shell
function nixdev() {
  nix develop $1 --command zsh
}

# enter a nix shell with package from unstable branch
function nixpkg-unstable() {
  nix shell nixpkgs/nixos-unstable#$1
}

function kitsd() {
  kitty --detach --session $1 && exit
}
