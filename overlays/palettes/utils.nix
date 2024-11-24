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
  removeHashtag = palette: lib.attrsets.mapAttrsRecursive (k: v:
    lib.strings.removePrefix "#" v) palette;


  # rgbWrap: formats a set of rgb hex values (e.g. for Hyprland)

  # Example:
  # foo = rgbWrap { bar = "ffffff"; };
  # -> foo = { bar = "rgb(ffffff)"; };

  rgbWrap = palette: lib.attrsets.mapAttrs (k: v: "rgb(${v})") palette;


  # rgbaWrap: formats a set of rgb hex values (e.g. for Hyprland)

  # Example:
  # foo = rgbWrap { bar = "ffffffcc"; };
  # -> foo = { bar = "rgb(ffffff)"; };

  # rgbaWrap = palette: lib.attrsets.mapAttrs (k: v: "rgba(${v}") palette;
}
