{ inputs, pkgs, ... }:

{
  imports = [ inputs.ags.homeManagerModules.default ];

  home.packages = with pkgs; [
    dart-sass
    gnome.adwaita-icon-theme
  ];

  programs.ags = {
    enable = true;
    configDir = null;

    extraPackages = [
      inputs.ags.packages.${pkgs.system}.battery
      # fzf
    ];
  };
}
