{ pkgs, config, ... }:

{
  imports = [
    ./fonts.nix
    ./hellwal.nix
    ./xresources.nix
  ];

  gtk = {
    enable = true;
    inherit (pkgs.theme.gtk) theme;
    gtk4.theme = config.gtk.theme;

    font = pkgs.theme.fonts.sansSerif;
    iconTheme = pkgs.theme.icons;
    cursorTheme = pkgs.theme.cursor;
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style.name = "breeze";
  };
}
