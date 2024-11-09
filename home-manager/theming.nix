{
  config,
  lib,
  pkgs,
  ...
}:
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
    package = (
      pkgs.catppuccin-papirus-folders.override {
        flavor = "macchiato";
        accent = "pink";
      }
    );
  };

  # Font packages
  myfont = pname: pkgs.callPackage ../pkgs/fonts/${pname} { };

  # Default fonts
  serif = sansSerif;
  sansSerif = {
    name = "Karla";
    package = pkgs.unstable.karla;
  };
  monospace = {
    name = "Hasklug Nerd Font Mono";
    package = pkgs.nerdfonts.override { fonts = [ "Hasklig" ]; };
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

    # Have the hashtag for viewing in the editor
    base16Scheme = lib.attrsets.mapAttrs (name: value: lib.strings.removePrefix "#" value) {
      # Modified Rose Pine Moon
      base00 = "#25223a"; # base
      base01 = "#312c48"; # surface
      base02 = "#38344e"; # overlay
      base03 = "#5d5573"; # muted
      base04 = "#9e92a5"; # subtle
      base05 = "#e8dfdd"; # text
      base06 = "#e8dfdd"; # text
      base07 = "#44415a"; # highlight med
      base08 = "#f281a6"; # red
      base09 = "#c37ac9"; # magenta
      base0A = "#efa4b7"; # yellow
      base0B = "#6990d6"; # green
      base0C = "#b1b5e4"; # cyan
      base0D = "#9673de"; # blue
      base0E = "#c37ac9"; # magenta
      base0F = "#55486b"; # highlight med
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
        plugin = "base16-nvim";
        transparentBackground = {
          main = true;
          signColumn = true;
        };
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

  programs.kitty =
    let
      colors = with config.lib.stylix.colors.withHashtag; {
        foreground = base06;
        background = base00;
        selection_background = base0F;

        # black
        color0 = base01;
        color8 = base02;

        color1 = red;
        color2 = green;
        color3 = yellow;
        color4 = blue;
        color5 = magenta;
        color6 = cyan;

        # white
        color7 = base03;
        color15 = base04;
      };

      colors-extended = with colors; {
        color9 = color1;
        color10 = color2;
        color11 = color3;
        color12 = color4;
        color13 = color5;
        color14 = color6;
      };
    in
    {
      settings = {
        # Fonts
        font_family = monospace.name;
        bold_font = "${monospace.name} SemBd";
        bold_italic_font = "${monospace.name} SemBd Italic";
        font_size = terminal-size;
        disable_ligatures = "cursor";

        # Colors
        cursor = "none"; # colored with the text underneath
        cursor_text_color = "background"; # fg colored with terminal background
        selection_foreground = "none";
      } // colors // colors-extended;
    };
}
