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
  ];

  home.packages = with pkgs; [
    voids.arttime
    fletchling
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
