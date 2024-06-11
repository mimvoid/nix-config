{ pkgs, ... }:

{
  home.packages = with pkgs; [
    hyprland-protocols
    xdg-desktop-portal-hyprland
    hyprcursor
    hyprpicker
    hyprshot
    swaybg
    swww
    libnotify
    networkmanagerapplet
  ];

  imports = [
    ./hyprland.nix
    ./hypr-theme.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./waybar.nix
    ./fuzzel.nix
    ./mako.nix
    ./wlsunset.nix
    ./wlogout.nix
  ];
}
