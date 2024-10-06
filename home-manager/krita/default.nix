{ pkgs, lib, ... }:
let
  reference-tabs-docker = pkgs.callPackage ../../packages/krita/reference-tabs-docker.nix {};
  composition-helper = pkgs.callPackage ../../packages/krita/composition-helper.nix {};
  timer-watch = pkgs.callPackage ../../packages/krita/timer-watch.nix {};

  gpl-palettes = pkgs.callPackage ../../packages/krita/gpl-palettes.nix {
    palettes = [
      "catppuccin-macchiato"
      "rose-pine-moon"
      "ayu-mirage"
    ];
  };

  pal = "${gpl-palettes}/share/krita/palettes";

  links = with lib.attrsets; {
    themes = mapAttrs' (name: value: nameValuePair
      ("krita/color-schemes/" + name) (value))
    {
      "CatppuccinMacchiatoMaroon.colors".source = ./CatppuccinMacchiatoMaroon.colors;
    };

    # Brushes, packs, etc.
    resources = mapAttrs' (name: value: nameValuePair
      ("krita/" + name) (value))
    {
      "Chalks_for_Children.bundle".source = ./Chalks_for_Children.bundle;
      "hollow_line.bundle".source = ./hollow_line.bundle;
      "SK_V1_.bundle".source = ./SK_V1_.bundle;
      "Rakurri_Gradient_Map_Set_V1.bundle".source = ./Rakurri_Gradient_Map_Set_V1.0.bundle;
    };

    # Krita can't seem to recognize the files in ~/.nix-profile/share/krita/palettes
    palettes = mapAttrs' (name: value: nameValuePair
      ("krita/palettes/" + name) (value))
    {
      "catppuccin-macchiato.gpl".source = "${pal}/catppuccin-macchiato.gpl";
      "rose-pine-moon.gpl".source = "${pal}/rose-pine-moon.gpl";
      "ayu-mirage.gpl".source = "${pal}/ayu-mirage.gpl";
    };
  };
in
{
  home.packages = [
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
