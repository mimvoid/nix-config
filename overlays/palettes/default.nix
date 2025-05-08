{ pkgs, ... }:
let
  utils = import ./lib { inherit (pkgs) lib; };

  # Usage examples:
  # pkgs.palettes.<name>.hex.noHashtag.<color-name>
  # pkgs.palettes.<name>.rgb.dec.<color-name>.r

  # See ./lib for what the functions do

  parse = palette:
    let
      inherit (pkgs.lib.attrsets) mapAttrsRecursive;

      inherit (utils.attrsets)
        noHashtag
        rgbWrap
        hexToRgb
        toDec
        isSplitRgb
        joinRgb
        ;

      # joinRgbCond = mapAttrsRecursive
      #   (as: !(isSplitRgb as))
      #   (_: value: joinRgb value);
    in
    rec {
      hex = {
        default = palette;
        noHashtag = noHashtag palette;
        rgbWrap = rgbWrap palette;
      };

      rgb = {
        split = hexToRgb palette;
        # default = joinRgbCond rgb.split;
        dec = toDec rgb.split;
      };
    };
in
rec {
  main = macchi-nightlight;
  lib = utils;

  moonfall-eve = parse (import ./moonfall/eve.nix);
  macchi-nightlight = parse (import ./catppuccin/macchi-nightlight.nix);
  catppuccin-macchiato = parse (import ./catppuccin/macchiato.nix);
}
