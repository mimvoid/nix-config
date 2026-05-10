{ pkgs, ... }:

{
  imports = [
    ./dooit
    ./ohmyposh
    ./shells
    ./yazi

    ./git.nix
    ./kitty.nix
    ./misc.nix
    ./neovim.nix
    ./pagers.nix
    ./todotui.nix
  ];

  home.packages = [
    pkgs.voids.arttime
    pkgs.fletchling
    pkgs.voids.fontpreview
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
