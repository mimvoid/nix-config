{ pkgs, ... }:
let
  utils = import ./utils.nix { inherit (pkgs) lib; };

  # Usage examples:
  # pkgs.palettes.<name>.hex.noHashtag.<color-name>
  # pkgs.palettes.<name>.rgb.dec.<color-name>.r

  # See ./utils.nix for what the functions do

  parse = palette: rec {
    hex = {
      default = palette;
      noHashtag = utils.removeHashtag palette;
      rgbWrap = utils.rgbWrap hex.noHashtag;
    };

    rgb = {
      split = utils.hexToRgb hex.noHashtag;
      dec = utils.toDec rgb.split;
    };
  };
in
rec {
  main = macchi-nightlight;
  lib = utils;

  macchi-nightlight = parse (import ./macchi-nightlight.nix);
}
