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
    package = (myfont "karla");
    name = "Karla";
  };

  monospace = {
    package = (pkgs.nerdfonts.override { fonts = [ "SourceCodePro" ];});
    name = "SauceCodePro NFM";
  };

  terminal-size = 14;
in
{
  home.packages = with pkgs; [
    wallust

    # Extra fonts
    # Sans serif
    noto-fonts-cjk-sans
    atkinson-hyperlegible
    raleway

    # Serif
    noto-fonts-cjk-serif

    # Monospace
    courier-prime
    fira-mono

    # Display / Handwriting
    norwester-font
  ]
  ++
  [
    (myfont "oswald")
    (myfont "major-mono-display")
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
    base16Scheme = {       # Modified rose pine moon
      base00 = "25223a";   # base
      base01 = "312c48";   # surface
      base02 = "38344e";   # overlay
      base03 = "5d5573";   # muted
      base04 = "9e92a5";   # subtle
      base05 = "e8dfdd";   # text
      base06 = "e8dfdd";   # text
      base07 = "56526e";   # highlight high
      base08 = "f281a6";   # red/love
      base09 = "c37ac9";   # magenta
      base0A = "efa4b7";   # yellow/rose
      base0B = "6990d6";   # green/pine
      base0C = "b1b5e4";   # cyan/foam
      base0D = "9673de";   # blue
      base0E = "c37ac9";   # magenta
      base0F = "56526e";   # highlight high
    };

    inherit cursor;

    fonts = {
      inherit serif;
      inherit sansSerif;
      inherit monospace;
      sizes.terminal = terminal-size;
    };

    targets = {
      bat.enable = true;
      foot.enable = true;
      fzf.enable = true;

      nixvim = {
        enable = true;
        transparentBackground.main = true;
        transparentBackground.signColumn = true;
      };

      yazi.enable = true;
      zathura.enable = true;
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

  # Stylix applies colors to Xresources weirdly,
  # so I'm doing this manually

  xresources.properties = let
    col = config.stylix.base16Scheme;
  in {
    "*.faceName" = monospace.name;
    "*.faceSize" = terminal-size;
    "*.renderFont" = true;
    "Xcursor.size" = cursor.size;
    "Xcursor.theme" = cursor.name;

    # special
    "*.foreground" = "#${col.base06}";
    "*.background" = "#${col.base00}";
    "*.cursorColor" = "#${col.base06}";

    # black
    "*.color0" = "#${col.base01}";
    "*.color8" = "#${col.base02}";

    # red
    "*.color1" = "#${col.base08}";
    "*.color9" = "#${col.base08}";

    # green
    "*.color2" = "#${col.base0B}";
    "*.color10" = "#${col.base0B}";

    # yellow
    "*.color3" = "#${col.base0A}";
    "*.color11" = "#${col.base0A}";

    # blue
    "*.color4" = "#${col.base0D}";
    "*.color12" = "#${col.base0D}";

    # magenta
    "*.color5" = "#${col.base09}";
    "*.color13" = "#${col.base09}";

    # cyan
    "*.color6" = "#${col.base0C}";
    "*.color14" = "#${col.base0C}";

    # white
    "*.color7" = "#${col.base03}";
    "*.color15" = "#${col.base04}";
  };
}
