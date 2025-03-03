{ pkgs, ... }:

{
  imports = [
    ./hyprland
    ./hypridle.nix
    ./hyprlock.nix
    ./fuzzel.nix
    ./wlsunset.nix
  ];

  home.packages = with pkgs; [
    wl-clipboard-rs
    hyprpicker
    swww
  ];
}
