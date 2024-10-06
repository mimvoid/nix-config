{ lib, ... }:

{
  options.palette = with lib; {
    base = mkOption {
      type = types.str;
      default = "24273a";
      description = "The background color, determines if the palette is light or dark.";
    };

    box = mkOption {
      type = types.str;
      default = "363a4f";
      description = ''
        Lighter (dark palette) or darker (light palette) than base.
        Often used for buttons, hover backgrounds, etc.
      '';
    };
    box-bright = mkOption {
      type = types.str;
      default = "494d64";
      description = "Color with more contrast with base than regular box.";
    };
    box-dim = mkOption {
      type = types.str;
      default = "363a4f";
      description = "Color with less contrast with base than regular box.";
    };

    string = mkOption {
      type = types.str;
      default = "cad3f5";
      description = "The foreground color, often for text or borders.";
    };
    string-dim = mkOption {
      type = types.str;
      default = "a5adcb";
      description = "Color with less contrast with base than regular string.";
    };

    shadow = mkOption {
      type = types.str;
      default = "000019";
      description = "A very dark color, often for box shadows.";
    };

    primary = mkOption {
      type = types.str;
      default = "f5bde6";
      description = "The main accent, with high emphasis.";
    };
    primary-bright = mkOption {
      type = types.str;
      default = "f5ccde";
      description = "A color lighter or warmer than primary.";
    };
    primary-dim = mkOption {
      type = types.str;
      default = "c6a0f6";
      description = "A color darker or cooler than primary.";
    };

    secondary = mkOption {
      type = types.str;
      default = "f0c6c6";
      description = "The accent with less emphasis, pairs well with the main accent.";
    };
    secondary-bright = mkOption {
      type = types.str;
      default = "f4dbd6";
      description = "A color lighter or warmer than secondary.";
    };
    secondary-dim = mkOption {
      type = types.str;
      default = "f5c2ab";
      description = "A color darker or cooler than secondary.";
    };

    tertiary = mkOption {
      type = types.str;
      default = "8aadf4";
      description = "The contrasting acccent with very high emphasis.";
    };
    tertiary-bright = mkOption {
      type = types.str;
      default = "91d6e3";
      description = "A color lighter or warmer than tertiary.";
    };
    tertiary-dim = mkOption {
      type = types.str;
      default = "b7bdf8";
      description = "A color darker or cooler than tertiary.";
    };

    good = mkOption {
      type = types.str;
      default = "8bd5ca";
      description = "An often green color, used for correctness or things that are fine.";
    };
    warn = mkOption {
      type = types.str;
      default = "f5a97f";
      description = "An often yellow or orange color, used for a warning.";
    };
    error = mkOption {
      type = types.str;
      default = "ee99a0";
      description = "An often red color, typically used for an error";
    };
  };
}
