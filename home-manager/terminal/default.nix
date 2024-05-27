{ config, pkgs, ... }:

{
  imports = [
    ./shell.nix
    ./foot.nix
    ./nixvim.nix
    ./yazi.nix
  ];
}
