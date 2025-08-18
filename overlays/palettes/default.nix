{ pkgs, ... }:
let
  utils = import ./lib { inherit (pkgs) lib; };

  # Usage examples:
  # pkgs.palettes.<name>.hexNoHashtag.<color-name>
  # pkgs.palettes.<name>.rgbDec.<color-name>.r

  # See ./lib for what the functions do

  parse = palette:
    let
      inherit (utils.attrsets)
        noHashtag
        rgbWrap
        hexToRgb
        joinRgb
        toDec
        ;
    in
    rec {
      hex = palette;
      hexNoHashtag = noHashtag palette;
      hexRgbWrap = rgbWrap palette;

      rgbSplit = hexToRgb palette;
      rgb = joinRgb rgbSplit;
      rgbDec = toDec rgbSplit;
    };
in
{
  lib = utils;

  moonfall-eve = parse (import ./moonfall/eve.nix);
  macchi-nightlight = parse (import ./catppuccin/macchi-nightlight.nix);
  catppuccin-macchiato = parse (import ./catppuccin/macchiato.nix);
}
