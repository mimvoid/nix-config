{ pkgs, ... }:

{
  home.packages = with pkgs; [
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
