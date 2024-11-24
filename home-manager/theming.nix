{ lib, pkgs, ... }:
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
    package = pkgs.mods.catppuccin-papirus-folders;
  };

  # Default fonts
  serif = sansSerif;
  sansSerif = {
    name = "Karla";
    package = pkgs.unstable.karla;
  };
  monospace = {
    name = "Hasklug Nerd Font Mono";
    package = pkgs.mods.nerdfonts;
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

    voids.fonts.limelight
    voids.fonts.ma-shan-zheng

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
    base16Scheme = lib.attrsets.mapAttrs (k: v: lib.strings.removePrefix "#" v) {
      # Moonfall Eve: A modified Rose Pine Moon
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
}
