{ inputs, pkgs, ... }:
let
  inherit (pkgs.theme)
    gtk
    cursor
    icons
    fonts
    ;
in
{
  imports = [ inputs.stylix.homeModules.stylix ];

  home.packages = pkgs.theme.packages;

  gtk = {
    inherit (gtk) theme;
    enable = true;
    font = fonts.sansSerif;
    iconTheme = icons;
    cursorTheme = cursor;
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style.name = "breeze";
  };

  stylix = {
    enable = true;
    autoEnable = false;

    base16Scheme = pkgs.palettes.moonfall-eve.hexNoHashtag.base16;

    inherit cursor;
    fonts = {
      inherit (fonts) serif sansSerif monospace;
      sizes.terminal = fonts.terminal-size;
    };

    targets = {
      fontconfig.enable = true;

      bat.enable = true;
      xresources.enable = true;
      yazi.enable = true;
      zathura.enable = true;
    };
  };
}
