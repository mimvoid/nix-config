{ pkgs }:

rec {
  cursor = {
    name = "BreezeX-RosePineDawn-Linux";
    package = pkgs.rose-pine-cursor;
    size = 24;
  };

  gtk.theme = {
    name = "rose-pine";
    package = pkgs.rose-pine-gtk-theme;
  };

  icons = {
    name = "Papirus";
    package = pkgs.mods.catppuccin-papirus-folders;
  };

  fonts = {
    sansSerif = {
      name = "Karla";
      package = pkgs.karla;
    };

    serif = fonts.sansSerif;

    monospace = {
      name = "0xProto Nerd Font Mono";
      package = pkgs.nerd-fonts._0xproto;
    };

    terminal-size = 12;
    terminal-size-float = 12.5;
  };

  packages = [
    gtk.theme.package
    icons.package
    cursor.package
    fonts.sansSerif.package
    fonts.serif.package
    fonts.monospace.package
  ];
}
