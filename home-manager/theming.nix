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

    oswald
    major-mono-display

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

    base16Scheme = pkgs.palettes.moonfall-eve.hex.noHashtag.base16;

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
