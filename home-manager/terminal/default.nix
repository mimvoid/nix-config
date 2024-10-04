{ pkgs, ... }:

{
  imports = [
    ./shell.nix
    ./git.nix
    ./kitty.nix
    ./yazi.nix
    ./dooit/default.nix
    ./navi/default.nix
  ];

  home.packages = with pkgs; [
    bluetuith

    gotop
    (callPackage ../../packages/arttime.nix {})
  ];
}
