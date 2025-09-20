{ pkgs, ... }:

{
  imports = [
    ./cli.nix
    ./git.nix
    ./shells
    ./kitty
    # ./starship
    ./ohmyposh
    ./yazi
    ./dooit
    ./navi
    ./rmpc
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
