{ config, pkgs, ... }:
let
  theme = {
    name = "rose-pine";
    package = pkgs.rose-pine-gtk-theme;
  };

  cursor = {
    name = "BreezeX-RosePineDawn-Linux";
    package = pkgs.rose-pine-cursor;
    size = 24;
  };

  icons = {
    name = "Papirus";
    package = (pkgs.catppuccin-papirus-folders.override {
      flavor = "macchiato";
      accent = "pink";
    });
  };

  # Font packages
  myfont = pname: pkgs.callPackage ../packages/fonts/${pname}.nix {};
 
  # Default fonts
  serif = sansSerif;
  sansSerif = {
    package = pkgs.unstable.karla;
    name = "Karla";
  };
  monospace = {
    package = pkgs.nerdfonts.override { fonts = [ "Hasklig" ];};
    name = "Hasklug Nerd Font Mono";
  };

  terminal-size = 14;
in
{
  home.packages = with pkgs; [
    # Sans serif
    noto-fonts-cjk-sans
    atkinson-hyperlegible
    raleway

    # Serif
    noto-fonts-cjk-serif

    # Monospace
    courier-prime

    # Display / Handwriting
    norwester-font
    unstable.oswald
    unstable.major-mono-display
  ] ++ [
    (myfont "limelight")
    (myfont "ma-shan-zheng")

    theme.package
    icons.package
    cursor.package
    sansSerif.package
    monospace.package
  ];

  stylix = {
    enable = true;
    autoEnable = false;
    
    base16Scheme = {       # Modified Rose Pine Moon
      base00 = "25223a";   # base
      base01 = "312c48";   # surface
      base02 = "38344e";   # overlay
      base03 = "5d5573";   # muted
      base04 = "9e92a5";   # subtle
      base05 = "e8dfdd";   # text
      base06 = "e8dfdd";   # text
      base07 = "44415a";   # highlight med
      base08 = "f281a6";   # red
      base09 = "c37ac9";   # magenta
      base0A = "efa4b7";   # yellow
      base0B = "6990d6";   # green
      base0C = "b1b5e4";   # cyan
      base0D = "9673de";   # blue
      base0E = "c37ac9";   # magenta
      base0F = "44415a";   # highlight med
    };

    inherit cursor;
    fonts = {
      inherit serif sansSerif monospace;
      sizes.terminal = terminal-size;
    };

    targets = {
      bat.enable = true;
      fzf.enable = true;
      yazi.enable = true;
      zathura.enable = true;
      nixvim = {
        enable = true;
        transparentBackground.main = true;
        transparentBackground.signColumn = true;
      };
    };
  };

  gtk = {
    enable = true;
    font = sansSerif;
    iconTheme = icons;
    cursorTheme = cursor;
    inherit theme;
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style.name = "breeze";
  };

  programs.kitty.settings = let
    c = config.lib.stylix.colors.withHashtag;
  in rec {
    # Fonts
    font_family = monospace.name;
    bold_font = "${monospace.name} SemBd";
    bold_italic_font = "${monospace.name} SemBd Italic";
    font_size = terminal-size;
    disable_ligatures = "cursor";

    # Colors
    cursor = "none"; # colored with the text underneath
    cursor_text_color = "background"; # fg colored with terminal background

    foreground = c.base06;
    background = c.base00;
    selection_foreground = "none";
    selection_background = c.base0F;
    
    # black
    color0 = c.base01;  color8 = c.base02;

    color1 = c.red;     color9 = color1;
    color2 = c.green;   color10 = color2;
    color3 = c.yellow;  color11 = color3;
    color4 = c.blue;    color12 = color4;
    color5 = c.magenta; color13 = color5;
    color6 = c.cyan;    color14 = color6;

    # white
    color7 = c.base03;  color15 = c.base04;
  };
}
