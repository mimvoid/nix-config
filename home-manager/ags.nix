{ inputs, pkgs, ... }:

{
  imports = [ inputs.ags.homeManagerModules.default ];

  home.packages = [
    pkgs.dart-sass
    pkgs.brightnessctl
    pkgs.adwaita-icon-theme
  ];

  programs.ags = {
    enable = true;
    configDir = null;

    extraPackages = builtins.attrValues {
      inherit (inputs.ags.packages.${pkgs.system})
        hyprland
        tray
        network
        bluetooth
        wireplumber
        battery
        notifd
        mpris
        cava
        ;
    };
  };
}
