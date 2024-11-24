{ config, pkgs, ... }:
let
  inherit (config) palette;
  inherit (config.stylix) fonts;

  # Theming configs
  font = "${fonts.monospace.name}:size=9";
  colors = with palette;
    {
      background = base + "ee";
      text = string + "ff";
      match = secondary + "ff";
      selection = box-bright + "dd";
      selection-match = primary + "ff";
      selection-text = secondary-bright + "ff";
      border = error + "ff";
    };
  icon-theme = config.gtk.iconTheme.name;
in
{
  programs.fuzzel = {
    enable = true;
    settings = {
      inherit colors;

      main = {
        inherit font icon-theme;
        terminal = "kitty";

        dpi-aware = true;
        width = 33;
        lines = 16;
        layer = "overlay";
        prompt = "'> '";
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

  # ------- #
  # Plugins #
  # ------- #

  # Networkmanager dmenu
  home.packages = with pkgs; [ networkmanager_dmenu ];
  xdg.configFile."networkmanager-dmenu/config.ini".text = # ini
    ''
      [dmenu]
      dmenu_command = fuzzel -d -w 40
      active_chars = >> # this doesn't work
      wifi_chars = ▂▄▆█
      wifi_icons = 󰤯󰤟󰤢󰤥󰤨
      format = {name:18}          {signal}%%  {bars}

      [editor]
      terminal = kitty
    '';
}
