{ pkgs, ... }:

{
  imports = [
    ./shells.nix
    ./cli.nix
    ./git.nix
    ./kitty
    ./starship
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
