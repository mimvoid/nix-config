{ pkgs, ... }:

{
  home.packages = with pkgs; [
    hyprland-protocols
    xdg-desktop-portal-hyprland
    hyprcursor
    hyprpicker
    hyprshot
    swww
    libnotify
    gnome.gnome-keyring
    networkmanagerapplet
  ];

  imports = [
    ./hyprland.nix
    ./hypr-theme.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./fuzzel.nix
    ./wlsunset.nix
    ./wlogout.nix
  ];
}
