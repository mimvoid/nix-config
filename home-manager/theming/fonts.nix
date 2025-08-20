{ pkgs, ... }:

{
  fonts.fontconfig.enable = true;

  home.packages = builtins.attrValues {
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
