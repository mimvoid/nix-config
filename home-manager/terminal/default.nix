{ pkgs, ... }:

{
  imports = [
    ./shell.nix
    ./cli.nix
    ./git.nix
    ./kitty.nix
    ./yazi.nix
    ./dooit/default.nix
    ./navi/default.nix
    ./fetcher/default.nix
  ];

  home.packages = with pkgs; [
    unstable.bluetui
    gotop
    (callPackage ../../packages/arttime.nix {})
  ];
}
