{ pkgs, ... }:

{
  imports = [
    ./hypr
    ./fuzzel.nix
    ./wlsunset.nix
  ];

  home.packages = with pkgs; [
    wl-clipboard-rs
    swww
  ];
}
