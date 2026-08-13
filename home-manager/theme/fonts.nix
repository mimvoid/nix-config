{ pkgs, ... }:
let
  inherit (pkgs.theme) fonts;
in
{
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = [ fonts.serif.name ];
      sansSerif = [ fonts.sansSerif.name ];
      monospace = [ fonts.monospace.name ];
    };
  };

  home.packages = builtins.attrValues {
    serif = fonts.serif.package;
    sansSerif = fonts.sansSerif.package;
    monospace = fonts.monospace.package;

    inherit (pkgs)
      # Sans serif
      noto-fonts-cjk-sans
      atkinson-hyperlegible-next
      raleway
      work-sans
      ostrich-sans
      public-sans
      open-sans
      montserrat

      # Serif
      noto-fonts-cjk-serif
      eb-garamond

      # Monospace
      courier-prime
      source-code-pro

      # Display / Handwriting
      norwester-font
      oswald
      major-mono-display
      ;

    inherit (pkgs.voids.fonts)
      # Fonts outside nixpkgs
      courier-prime-sans
      limelight
      ma-shan-zheng
      ritzflf
      ;
  };
}
