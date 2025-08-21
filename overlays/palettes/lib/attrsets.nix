{ lib }:
let
  inherit (lib.attrsets) mapAttrsRecursive;
  strings = import ./strings.nix { inherit lib; };
in
rec {
  /**
    Remove hashtag prefixes throughout an attribute set.

    # Type

    noHashtag :: attrset -> attrset

    # Examples

    removeHashtag { bar = "#ffffff"; alpha = { baz = "#000000cc"; }; };
    => { bar = "ffffff"; alpha = { baz = "000000cc"; }; };
  */
  noHashtag = mapAttrsRecursive (_name: value: strings.noHashtag value);

  /**
    Surround the values of an attribute set with "rgb()" or "rgba()".
    Useful for configs like Hyprland's.

    # Type

    rgbWrap :: attrset -> attrset

    # Examples

    rgbWrap { bar = "#ffffff"; alpha = { baz = "#000000cc"; }; };
    => { bar = "rgb(ffffff)"; alpha = { baz = "rgba(000000cc)"; }; };
  */
  rgbWrap = mapAttrsRecursive (_name: value: strings.rgbWrap value);

  /**
    Convert a set of hex values to subsets of red, green, blue, and alpha values.

    # Type

    hexToRgb :: attrset -> attrset

    # Examples

    hexToRgb { bar = "#ffffff"; alpha = { baz = "#000000"; }; };
    => {
      bar = { a = 255; b = 255; g = 255; r = 255; };
      alpha = {
        baz = { a = 204; b = 255; g = 255; r = 255; };
      };
    };
  */
  hexToRgb = mapAttrsRecursive (_name: value: strings.hexToRgb value);

  isSplitRgb = set: set ? r && set ? g && set ? b;

  isSplitRgba = set: isSplitRgb set && set ? a;

  /**
    Convert an attribute set of RGB values into decimal percentages.

    # Type

    toDec :: attrset -> attrset

    # Examples

    toDec { a = 204; b = 255; g = 250; r = 245; };
    => { a = 0.8; b = 1; g = 0.980392; r = 0.960784; };
  */
  toDec = mapAttrsRecursive (_name: value: strings.toDec value);

  /**
    Join an attribute set of RGB values into an RGB string.
    Ignores any alpha value.

    # Type

    joinRgb :: attrset -> string

    # Examples

    joinRgb { a = 204; b = 255; g = 250; r = 245; };
    => "rgb(245,250,255)"
  */
  joinRgb = { r, g, b, ... }:
    "rgb(${toString r},${toString g},${toString b})";

  /**
    Join an attribute set of RGB values into an RGBA string.
  */
  joinRgba = { r, g, b, a }:
    "rgba(${toString r},${toString g},${toString b},${toString a})";
}
