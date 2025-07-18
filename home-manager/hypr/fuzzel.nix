{ config, pkgs, ... }:
let
  inherit (pkgs.theme.fonts) monospace;

  # Theming configs
  font = "${monospace.name}:size=9";
  icon-theme = config.gtk.iconTheme.name;
in
{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        inherit font icon-theme;
        include = "~/.config/fuzzel/colors.ini"; # matugen
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

        match-counter = true;
      };

      border = {
        width = 2;
        radius = 8;
      };
    };
  };

  # ------- #
  # Plugins #
  # ------- #

  # Networkmanager dmenu
  home.packages = with pkgs; [ networkmanager_dmenu ];

  xdg.configFile."networkmanager-dmenu/config.ini".text = /* ini */ ''
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
