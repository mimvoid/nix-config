{ pkgs, ... }:

{
  imports = [
    ./dooit
    ./ohmyposh
    ./shells
    ./yazi

    ./fontpreview.nix
    ./git.nix
    ./kitty.nix
    ./misc.nix
    ./neovim.nix
    ./pagers.nix
  ];

  home.packages = [
    pkgs.voids.arttime
    pkgs.fletchling
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
