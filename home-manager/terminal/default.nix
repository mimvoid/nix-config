{ pkgs, ... }:

{
  imports = [
    ./shell.nix
    ./git.nix
    ./kitty.nix
    ./navi/navi.nix
    ./yazi.nix
  ];

  home.packages = with pkgs; [
    bluetuith

    gotop
    dooit

    (callPackage ../../packages/arttime.nix {})
  ];
}
