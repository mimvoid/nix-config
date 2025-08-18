{ pkgs, ... }:

{
  imports = [
    ./xfconf
    ./cortile.nix
    ./picom.nix
  ];

  home.packages = [ pkgs.xclip ];
}
