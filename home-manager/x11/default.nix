{ pkgs, ... }:

{
  imports = [
    ./xfconf
    ./cortile.nix
    ./picom.nix
  ];

  home.packages = with pkgs; [ xclip ];
}
