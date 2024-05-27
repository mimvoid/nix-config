{ config, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    kdePackages.qt6ct
  ]

  qt = {
    enable = true;
    platformTheme = {
      name = "qt6ct";
      package = kdePackages.qt6ct;
    };
    style.name = "breeze";
  };
}
