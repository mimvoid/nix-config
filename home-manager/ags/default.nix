{ inputs, pkgs, ... }:

{
  imports = [ inputs.ags.homeManagerModules.default ];

  home.packages = with pkgs; [
    dart-sass
    brightnessctl
    adwaita-icon-theme
  ];

  programs.ags = {
    enable = true;
    configDir = null;

    extraPackages = with inputs.ags.packages.${pkgs.system}; [
      hyprland
      tray
      network
      bluetooth
      wireplumber
      battery
      notifd
      mpris
      cava
    ];
  };

  xdg.configFile."wallpapers".source = ../../wallpapers/wallpapers;
}
