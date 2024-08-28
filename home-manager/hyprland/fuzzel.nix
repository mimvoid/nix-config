{ config, pkgs, ... }:

{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "foot";

        dpi-aware = true;
        width = 33;
        lines = 16;
        layer = "overlay";
        prompt = "'> '";
        icon-theme = config.gtk.iconTheme.name;
        exit-on-keyboard-focus-loss = false;

        horizontal-pad = 28;
        vertical-pad = 18;
        inner-pad = 16;

        fields = "filename,name";
        tabs = 4;
      };
      border.radius = 8;
    };
  };

  # Networkmanager dmenu
  home.packages = [ pkgs.networkmanager_dmenu ];

  xdg.configFile."networkmanager-dmenu/config.ini".text = # ini
  ''
    [dmenu]
    dmenu_command = fuzzel -d -w 40
    active_chars = >> # this doesn't work
    wifi_chars = ▂▄▆█
    wifi_icons = 󰤯󰤟󰤢󰤥󰤨
    format = {name:18}          {signal}%%  {bars}

    [editor]
    terminal = foot
  '';
}
