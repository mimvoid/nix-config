{ lib, ... }:

{
  # removeHashtag: removes prefix hashtags throughout an attribute set

  /*
    Example:
    foo = removeHashtag {
      bar = "#ffffff";
      alpha = { baz = "#000000"; };
    };
    -> foo = {
      bar = "ffffff";
      alpha = { baz = "000000"; };
    };
  */
  removeHashtag = palette: lib.attrsets.mapAttrsRecursive
    (k: v: lib.strings.removePrefix "#" v)
    palette;


  # listRemoveHashtag: same as removeHashtag, but for a list of strings

  listRemoveHashtag = palette: lib.lists.map
    (i: lib.strings.removePrefix "#" i)
    palette;


  # rgbWrap: formats a set of rgb hex values (e.g. for Hyprland)
  # A bit hacky, but it's good enough for my uses

  /*
    Example:
    foo = rgbWrap {
      bar = "ffffff";
      alpha = { baz = "ffffffcc"; };
    };

    -> foo = {
      bar = "rgb(ffffff)";
      alpha = { baz = "rgba(ffffffcc)"; };
    };
  */

  rgbWrap = palette: lib.attrsets.mapAttrsRecursive
    (k: v:
      if lib.strings.stringLength v == 8 then
        "rgba(${v})"
      else
        "rgb(${v})"
    )
    palette;


  # hexToRgb: convert a set of hex values to subsets of r, g, b, and a
  # Also a bit hacky

  /*
    Example:
    foo = hexToRgb {
      bar = "ffffff";
      alpha = {
        baz = "ffffffcc";
      };
    };

    -> foo = {
      bar = { a = 255; b = 255; g = 255; r = 255; };
      alpha = {
        baz = { a = 204; b = 255; g = 255; r = 255; };
      };
    };
  */

  hexToRgb = palette: lib.attrsets.mapAttrsRecursive (k: v:
    let
      # Give the starting index of the substring to convert
      fromHex = start: lib.trivial.fromHexString (lib.strings.substring start 2 v);

      # Get the hex values
      r = fromHex 0;
      g = fromHex 2;
      b = fromHex 4;

      # Get the alpha value as a float if it exists
      # Otherwise, set it to 255
      a = if lib.strings.stringLength v == 8 then (fromHex 6) else 255;
    in
    { inherit r g b a; }
  ) palette;


  # toDec: converts a set of rgb values into decimal percentages

  # Example:
  # foo = toDec {
  #   bar = { a = 204; b = 255; g = 250; r = 245; };
  # };
  # -> foo = {
  #   bar = { a = 0.8; b = 1; g = 0.980392; r = 0.960784; };
  # };

  toDec = palette: lib.attrsets.mapAttrsRecursive (k: v: v / 255.0);
}
