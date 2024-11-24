{ lib, ... }:
let
  utils = import ./utils.nix { inherit lib; };

  parse = palette: {
    hex = {
      default = palette;
      noHashtag = utils.removeHashtag palette;
      # rgbWrap = utils.rgbWrap palette;
    };
  };
in
rec {
  current = macchi-nightlight;
  inherit utils;

  macchi-nightlight = parse (import ./macchi-nightlight.nix);
}
