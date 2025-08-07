{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    fuzzel
    networkmanager_dmenu
  ];

  xdg.configFile."fuzzel/fuzzel.ini".text =
    let
      font = "${pkgs.theme.fonts.monospace.name}:size=9";
      icon-theme = config.gtk.iconTheme.name;
    in
    # ini
    ''
      include = ~/.config/fuzzel/colors.ini # matugen

      font = ${font}
      icon-theme = ${icon-theme}
      terminal = kitty

      prompt = "> "
      width = 33
      lines = 16
      dpi-aware = yes
      layer = overlay

      horizontal-pad = 28
      vertical-pad = 18
      inner-pad = 16

      fields = filename,name
      tabs = 4

      exit-on-keyboard-focus-loss = no
      match-counter = yes

      [border]
      width = 2
      radius = 8
    '';

  # ------- #
  # Plugins #
  # ------- #

  # Networkmanager dmenu
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
