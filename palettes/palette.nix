{ lib, ... }:

{
  options.palette = {
    base = lib.mkOption {
      type = lib.types.str;
      default = "24273a";
      description = "The background color, determines if the palette is light or dark.";
    };

    box = lib.mkOption {
      type = lib.types.str;
      default = "363a4f";
      description = ''
        Lighter (dark palette) or darker (light palette) than base.
        Often used for buttons, hover backgrounds, etc.
      '';
    };
    box-bright = lib.mkOption {
      type = lib.types.str;
      default = "494d64";
      description = "Color with more contrast with base than regular box.";
    };
    box-dim = lib.mkOption {
      type = lib.types.str;
      default = "363a4f";
      description = "Color with less contrast with base than regular box.";
    };

    string = lib.mkOption {
      type = lib.types.str;
      default = "cad3f5";
      description = "The foreground color, often for text or borders.";
    };
    string-dim = lib.mkOption {
      type = lib.types.str;
      default = "a5adcb";
      description = "Color with less contrast with base than regular string.";
    };

    shadow = lib.mkOption {
      type = lib.types.str;
      default = "000019";
      description = "A very dark color, often for box shadows.";
    };

    primary = lib.mkOption {
      type = lib.types.str;
      default = "f5bde6";
      description = "The main accent, with high emphasis.";
    };
    primary-bright = lib.mkOption {
      type = lib.types.str;
      default = "f5ccde";
      description = "A color lighter or warmer than primary.";
    };
    primary-dim = lib.mkOption {
      type = lib.types.str;
      default = "c6a0f6";
      description = "A color darker or cooler than primary.";
    };

    secondary = lib.mkOption {
      type = lib.types.str;
      default = "f0c6c6";
      description = "The accent with less emphasis, pairs well with the main accent.";
    };
    secondary-bright = lib.mkOption {
      type = lib.types.str;
      default = "f4dbd6";
      description = "A color lighter or warmer than secondary.";
    };
    secondary-dim = lib.mkOption {
      type = lib.types.str;
      default = "f5c2ab";
      description = "A color darker or cooler than secondary.";
    };

    tertiary = lib.mkOption {
      type = lib.types.str;
      default = "8aadf4";
      description = "The contrasting acccent with very high emphasis.";
    };
    tertiary-bright = lib.mkOption {
      type = lib.types.str;
      default = "91d6e3";
      description = "A color lighter or warmer than tertiary.";
    };
    tertiary-dim = lib.mkOption {
      type = lib.types.str;
      default = "b7bdf8";
      description = "A color darker or cooler than tertiary.";
    };

    good = lib.mkOption {
      type = lib.types.str;
      default = "8bd5ca";
      description = "An often green color, used for correctness or things that are fine.";
    };
    warn = lib.mkOption {
      type = lib.types.str;
      default = "f5a97f";
      description = "An often yellow or orange color, used for a warning.";
    };
    error = lib.mkOption {
      type = lib.types.str;
      default = "ee99a0";
      description = "An often red color, typically used for an error";
    };
  };
}
