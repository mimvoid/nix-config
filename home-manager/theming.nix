{ config, pkgs, ... }:
let
  theme = {
    name = "rose-pine-moon";
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
      accent = "blue";
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
    base16Scheme = {        # Rose pine moon
      base00 = "232136";   # base
      base01 = "2a273f";   # surface
      base02 = "393552";   # overlay
      base03 = "6e6a86";   # muted
      base04 = "908caa";   # subtle
      base05 = "e0def4";   # text
      base06 = "e0def4";   # text
      base07 = "56526e";   # highlight high
      base08 = "eb6f92";   # love
      base09 = "f6c177";   # gold
      base0A = "ea9a97";   # rose
      base0B = "3e8fb0";   # pine
      base0C = "9ccfd8";   # foam
      base0D = "c4a7e7";   # iris
      base0E = "f6c177";   # gold
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

    # magenta (this hurts)
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
