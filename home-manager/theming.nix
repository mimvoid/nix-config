{ pkgs, ... }:
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
    autoEnable = false;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine-moon.yaml";

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

  xfconf.settings.xsettings."Gtk/CursorThemeSize" = 38;

  xresources = {
    properties = {
      "*.faceName" = monospace.name;
      "*.faceSize" = terminal-size;
      "*.renderFont" = true;
      "Xcursor.size" = cursor.size;
      "Xcursor.theme" = cursor.name;

      # Rose pine for Xresources is different from that of base 16,
      # so I made this manually to match it.

      # special
      "*.foreground" = "#e0def4";
      "*.background" = "#232136";
      "*.cursorColor" = "#e0def4";

      # black
      "*.color0" = "#2a273f";
      "*.color8" = "#393552";

      # red
      "*.color1" = "#eb6f92";
      "*.color9" = "#eb6f92";

      # green
      "*.color2" = "#3e8fb0";
      "*.color10" = "#3e8fb0";

      # yellow
      "*.color3" = "#ea9a97";
      "*.color11" = "#ea9a97";

      # blue
      "*.color4" = "#c4a7e7";
      "*.color12" = "#c4a7e7";

      # magenta (this hurts)
      "*.color5" = "#f6c177";
      "*.color13" = "#f6c177";

      # cyan
      "*.color6" = "#9ccfd8";
      "*.color14" = "#9ccfd8";

      # white
      "*.color7" = "#6e6a86";
      "*.color15" = "#908caa";
    };
  };
}
