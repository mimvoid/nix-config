{ pkgs, ... }:

{
  imports = [
    ./shell.nix
    ./git.nix
    ./kitty.nix
    ./bluetuith.nix
    ./yazi.nix
    ./dooit/default.nix
    ./navi/default.nix
  ];

  home.packages = with pkgs; [
    gotop
    (callPackage ../../packages/arttime.nix {})
  ];
}
