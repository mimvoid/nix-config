{ config, pkgs, ... }:
let
  inherit (pkgs.theme.fonts) monospace;

  # Theming configs
  font = "${monospace.name}:size=9";
  colors = with pkgs.palettes.main.hex.noHashtag.alpha;
    {
      background = base;
      text = string;
      match = secondary;
      selection = box-bright;
      selection-match = primary;
      selection-text = secondary-bright;
      border = error;
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
      active_chars = >
      wifi_chars = ▂▄▆█
      wifi_icons = 󰤯󰤟󰤢󰤥󰤨
      format = {name:18}           {signal}%%  {bars}

      [editor]
      terminal = kitty
    '';
}
