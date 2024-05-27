{ config, pkgs, ... }:

{
  imports = [
    ./shell-tools.nix
    ./foot.nix
    ./nixvim.nix
    ./yazi.nix
  ];
}
