{ inputs, pkgs, ... }:
let
  inherit (pkgs.theme)
    gtk
    cursor
    icons
    fonts
    ;
in
{
  imports = [ inputs.stylix.homeManagerModules.stylix ];

  home.packages = with pkgs; [
    ## Fonts
    # Sans serif
    noto-fonts-cjk-sans
    unstable.atkinson-hyperlegible-next
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
  ]
  ++ (with pkgs.voids.fonts; [
    # Fonts outside nixpkgs
    limelight
    ma-shan-zheng
    ritzflf
  ])
  ++ pkgs.theme.packages;


  # home.pointerCursor = {
  #   inherit (cursor) name package size;
  #   x11.enable = true;
  #   gtk.enable = true;
  # };
  #
  # fonts.fontconfig =
  #   let
  #     inherit (fonts) sansSerif serif monospace;
  #   in
  #   {
  #   enable = true;
  #   defaultFonts = {
  #     sansSerif = [ sansSerif.name ];
  #     serif = [ serif.name ];
  #     monospace = [ monospace.name ];
  #   };
  # };


  gtk = {
    inherit (gtk) theme;
    enable = true;
    font = fonts.sansSerif;
    iconTheme = icons;
    cursorTheme = cursor;
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style.name = "breeze";
  };


  stylix = {
    enable = true;
    autoEnable = false;

    base16Scheme = pkgs.palettes.moonfall-eve.hex.noHashtag.base16;

    inherit cursor;

    fonts = {
      inherit (fonts) serif sansSerif monospace;
      sizes.terminal = fonts.terminal-size;
    };

    targets = {
      bat.enable = true;
      fzf.enable = true;
      xresources.enable = true;
      yazi.enable = true;
      zathura.enable = true;
    };
  };
}
