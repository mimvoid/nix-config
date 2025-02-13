{ pkgs, ... }:
let
  inherit (pkgs.voids.lib) prependAttrs;

  themes = prependAttrs "krita/color-schemes/" {
    "CatppuccinMacchiatoMaroon.colors".source = ./CatppuccinMacchiatoMaroon.colors;
  };

  # Krita can't seem to recognize the files in ~/.nix-profile/share/krita/palettes
  pal = "${pkgs.voids.gpl-palettes}/share/krita/palettes";

  palettes = prependAttrs "krita/palettes/" {
    "catppuccin-macchiato.gpl".source = "${pal}/catppuccin-macchiato.gpl";
    "rose-pine-moon.gpl".source = "${pal}/rose-pine-moon.gpl";
    "ayu-mirage.gpl".source = "${pal}/ayu-mirage.gpl";
  };
in
{
  imports = [
    ./resources
    ./scripts
  ];

  home.packages = with pkgs.voids.krita; [
    reference-tabs-docker
    composition-helper
    timer-watch
    shortcut-composer
  ];

  xdg.dataFile = {
    # Krita thumbnails
    "thumbnailers/kra.thumbnailer".text = ''
      [Thumbnailer Entry]
      TryExec=unzip
      Exec=sh -c "${pkgs.unzip}/bin/unzip -p %i preview.png > %o"
      MimeType=application/x-krita;
    '';
  }
  // themes
  // palettes;
}
