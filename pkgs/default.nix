{ pkgs }:

let
  inherit (pkgs) callPackage;
in
{
  arttime = callPackage ./arttime { };
  cortile = callPackage ./cortile { };
  fontpreview = callPackage ./fontpreview { };
  freetube = callPackage ./freetube { };
  mdopen = callPackage ./mdopen { };
  zsh-help = callPackage ./zsh-help { };

  gpl-palettes = callPackage ./gpl-palettes {
    palettes = [
      "catppuccin-macchiato"
      "rose-pine-moon"
      "ayu-mirage"
    ];
  };

  fonts = import ./fonts { inherit pkgs; };
  krita = import ./krita { inherit pkgs; };
  yaziPlugins = import ./yazi { inherit pkgs; };
}
