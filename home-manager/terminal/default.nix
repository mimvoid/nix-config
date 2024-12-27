{ pkgs, ... }:

{
  imports = [
    ./shells.nix
    ./cli.nix
    ./git.nix
    ./kitty.nix
    ./yazi.nix
    ./dooit
    ./navi
  ];

  home.packages = with pkgs; [
    unstable.bluetui
    voids.arttime
    fletchling
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
