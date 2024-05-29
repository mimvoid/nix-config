{ pkgs, ... }:

{
    home.packages = with pkgs; [
        hyprland-protocols
        xdg-desktop-portal-hyprland
        hyprcursor
        hyprpicker
        hyprshot
        eww
        swaybg
        libnotify
        networkmanagerapplet
    ];

    imports = [
        ./hyprland.nix
        ./hypridle.nix
        ./hyprlock.nix
        ./waybar.nix
        ./fuzzel.nix
        ./mako.nix
        ./wlsunset.nix
        ./wlogout.nix
    ];
}
