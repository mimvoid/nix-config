{ pkgs, ... }:

{
  imports = [
    ./hyprland.nix
    ./hypridle.nix
    ./hyprlock.nix
  ];

  home.packages = with pkgs; [
    hyprpicker
  ];
}
