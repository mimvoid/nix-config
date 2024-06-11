{ pkgs, ... }:

{
  home.packages = with pkgs; [
    hyprland-protocols
    xdg-desktop-portal-hyprland
    hyprcursor
    hyprpicker
    hyprshot
    swaybg
    libnotify
    networkmanagerapplet
  ];

  imports = [
    ./hyprland.nix
    ./hypr-theme.nix
    ./hyprpaper.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./waybar.nix
    ./fuzzel.nix
    ./mako.nix
    ./wlsunset.nix
    ./wlogout.nix
  ];
}
