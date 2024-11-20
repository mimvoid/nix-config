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
    ./fetcher
  ];

  home.packages = with pkgs; [
    unstable.bluetui
    voids.arttime
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
