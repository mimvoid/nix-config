{ pkgs, ... }:
let
  inherit (pkgs.my-utils) prependAttrs;

  links = {
    themes = prependAttrs "krita/color-schemes/" {
      "CatppuccinMacchiatoMaroon.colors".source = ./CatppuccinMacchiatoMaroon.colors;
    };

    # Brushes, packs, etc.
    resources = prependAttrs "krita/" {
      "Chalks_for_Children.bundle".source = ./Chalks_for_Children.bundle;
      "hollow_line.bundle".source = ./hollow_line.bundle;
      "SK_V1_.bundle".source = ./SK_V1_.bundle;
      "Rakurri_Gradient_Map_Set_V1.bundle".source = ./Rakurri_Gradient_Map_Set_V1.0.bundle;
    };

    # Krita can't seem to recognize the files in ~/.nix-profile/share/krita/palettes
    palettes =
      let
        pal = "${pkgs.voids.gpl-palettes}/share/krita/palettes";
      in
      prependAttrs "krita/palettes/" {
        "catppuccin-macchiato.gpl".source = "${pal}/catppuccin-macchiato.gpl";
        "rose-pine-moon.gpl".source = "${pal}/rose-pine-moon.gpl";
        "ayu-mirage.gpl".source = "${pal}/ayu-mirage.gpl";
      };
  };
in
{
  home.packages = with pkgs.voids.krita; [
    reference-tabs-docker
    composition-helper
    timer-watch
  ];

  xdg.dataFile = {
    # Krita thumbnails
    "thumbnailers/kra.thumbnailer".text = ''
      [Thumbnailer Entry]
      TryExec=unzip
      Exec=sh -c "${pkgs.unzip}/bin/unzip -p %i preview.png > %o"
      MimeType=application/x-krita;
    '';
  } // links.themes // links.resources // links.palettes;
}
