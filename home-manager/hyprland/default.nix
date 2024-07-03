{ pkgs, ... }:

{
  home.packages = with pkgs; [
    hyprland-protocols
    xdg-desktop-portal-hyprland

    gnome.gnome-keyring
    networkmanagerapplet
    
    wl-clipboard
    hyprcursor
    hyprpicker
    hyprshot
    swww
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
