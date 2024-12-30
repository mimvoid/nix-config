{ pkgs, ... }:
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

  terminal-size = 13;
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
    voids.fonts.ritzflf

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
    base16Scheme = pkgs.palettes.utils.removeHashtag {
      # Moonfall Eve: A modified Rose Pine Moon
      base00 = "#25223a"; # base
      base01 = "#302c47"; # surface
      base02 = "#37324f"; # overlay
      base03 = "#5c5478"; # muted
      base04 = "#9c92aa"; # subtle
      base05 = "#e8dfdd"; # text
      base06 = "#e8dfdd"; # text
      base07 = "#44415b"; # highlight med
      base08 = "#f280aa"; # red
      base09 = "#d87dd6"; # magenta
      base0A = "#eda2b5"; # yellow
      base0B = "#7098de"; # green
      base0C = "#b1b5e4"; # cyan
      base0D = "#a675eb"; # blue
      base0E = "#d87dd6"; # magenta
      base0F = "#52486d"; # highlight med
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
