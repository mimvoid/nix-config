{ pkgs, ... }:

{
  imports = [
    ./hyprland
    ./hypridle.nix
    ./hyprlock.nix
    ./fuzzel.nix
    ./swww.nix
    ./wlsunset.nix
  ];

  home.packages = with pkgs; [
    wl-clipboard-rs
    hyprpicker
    hyprshot
  ];
}
