{ lib }:

rec {
  /**
    Remove the leading "#" from a string, if it exists.

    # Type

    noHashtag :: string -> string

    # Examples

    noHashtag "#ffffff"
    => "ffffff"

    noHashtag "000000"
    => "000000"
  */
  noHashtag = lib.strings.removePrefix "#";

  /**
    Surround a string with "rgb()" or "rgba()".
    Useful for config files like Hyprland's.

    # Type

    rgbWrap :: string -> string

    # Examples

    rgbWrap "#ffffff"
    => "rgb(ffffff)"

    rgbWrap "#f02bab33"
    => "rgba(f02bab33)"
  */
  rgbWrap =
    s:
    let
      hex = noHashtag s;
    in
    if builtins.stringLength hex == 8 then "rgba(${hex})" else "rgb(${hex})";

  /**
    Convert a hex RGB string to an attrset of red, green, blue, and alpha values.

    # Type

    hexToRgb :: string -> attrset

    # Examples

    hexToRgb "ffffff"
    => { a = 255; b = 255; g = 255; r = 255; };

    hexToRgb "#ffffffcc"
    => { a = 204; b = 255; g = 255; r = 255; };
  */
  hexToRgb =
    s:
    let
      hex = noHashtag s;
      len = builtins.stringLength hex;
      numChars = if len == 3 then 1 else 2;

      # Takes the starting index of the substring
      fromHex = startIndex: lib.trivial.fromHexString (builtins.substring startIndex numChars hex);
    in
    {
      r = fromHex 0;
      g = fromHex numChars;
      b = fromHex (numChars * 2);

      # Get the alpha value if it exists, defaults to 255
      a = if len == 8 then (fromHex 6) else 255;
    };

  /**
    (Not a string function)
    Divide a number by 255.0. Useful for RGB values.

    # Type

    toDec :: int|float -> float

    # Examples

    toDec 204
    => 0.8

    toDec 250
    => 0.980392
  */
  toDec = num: num / 255.0;

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
