{ inputs, pkgs, config, ... }:
let
  inherit (config.voids) flakeDir;

  ags-pkgs = inputs.ags.packages.${pkgs.stdenv.hostPlatform.system};
  ags = ags-pkgs.ags.override {
    extraPackages = builtins.attrValues {
      inherit (ags-pkgs)
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
in
{
  home.packages = [
    ags
    pkgs.dart-sass
    pkgs.brightnessctl
    pkgs.adwaita-icon-theme
  ];

  xdg.configFile."ags".source = config.lib.file.mkOutOfStoreSymlink "${flakeDir}/home/ags";
}
