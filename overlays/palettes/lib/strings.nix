{ lib }:

let
  inherit (lib.strings)
    removePrefix
    stringLength
    substring
    ;
in

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
  noHashtag = removePrefix "#";

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
  rgbWrap = s:
    let
      hex = noHashtag s;
    in
    if stringLength hex == 8 then
      "rgba(${hex})"
    else
      "rgb(${hex})";

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
  hexToRgb = s:
    let
      hex = noHashtag s;

      # Give the starting index of the substring to convert
      fromHex = start: lib.trivial.fromHexString (substring start 2 hex);

      # Get the hex values
      r = fromHex 0;
      g = fromHex 2;
      b = fromHex 4;

      # Get the alpha value as a float if it exists
      # Otherwise, set it to 255
      a = if stringLength hex == 8 then (fromHex 6) else 255;
    in
    { inherit r g b a; };

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
}
