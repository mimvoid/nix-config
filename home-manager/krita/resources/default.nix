{ pkgs, ... }:
let
  inherit (pkgs.voids.lib) prependAttrs;
in
{
  # Brushes, packs, etc.
  xdg.dataFile = prependAttrs "krita/" {
    "Chalks_for_Children.bundle".source = ./Chalks_for_Children.bundle;
    "hollow_line.bundle".source = ./hollow_line.bundle;
    "SK_V1_.bundle".source = ./SK_V1_.bundle;
    "Rakurri_Gradient_Map_Set_V1.bundle".source = ./Rakurri_Gradient_Map_Set_V1.0.bundle;
  };
}
