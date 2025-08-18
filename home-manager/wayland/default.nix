{ pkgs, ... }:

{
  imports = [
    ./hypr
    ./fuzzel.nix
    ./wlsunset.nix
  ];

  home.packages = [
    pkgs.wl-clipboard-rs
    pkgs.swww
  ];
}
