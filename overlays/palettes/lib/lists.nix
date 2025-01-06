{ lib }:
let
  inherit (lib.lists)
    map
    ;

  strings = import ./strings.nix { inherit lib; };
in
{
  /**
    Remove hashtag prefixes throughout a list of strings.

    # Type

    noHashtag :: [string] -> [string]

    # Examples

    removeHashtag [ "#ffffff" "000000cc" ]
    => [ "ffffff" "000000cc" ];
  */
  removeHashtag = map (i: strings.noHashtag i);

  /**
    Surround strings in a list with "rgb()" or "rgba()".
    Useful for configs like Hyprland's.

    # Type

    rgbWrap :: [string] -> [string]

    # Examples

    rgbWrap [ "#ffffff" "000000cc" ]
    => [ "rgb(ffffff)" "rgba(000000cc)" ];
  */
  rgbWrap = map (i: strings.rgbWrap i);

  /**
    Convert a list of hex values to a list of attributes of
    red, green, blue, and alpha values.

    # Type

    hexToRgb :: [string] -> [attrset]

    # Examples

    hexToRgb [ "#ffffff" "#000000cc" ]
    => [
      { a = 255; b = 255; g = 255; r = 255; }
      { a = 204; b = 255; g = 255; r = 255; }
    ]
  */
  hexToRgb = map (i: strings.hexToRgb i);

  /**
    Convert a list of RGB values into decimal percentages.

    # Type

    toDec :: [int|float] -> [float]

    # Examples

    toDec [ 204 255 250 245 ]
    => [ 0.8 1 0.980392 0.960784 ]
  */
  toDec = map (i: strings.toDec i);
}
