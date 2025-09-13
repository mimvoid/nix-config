{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.fuzzel
    pkgs.networkmanager_dmenu
  ];

  xdg.configFile."fuzzel/fuzzel.ini".text =
    let
      font = "${pkgs.theme.fonts.monospace.name}:size=9";
      icon-theme = config.gtk.iconTheme.name;
    in
    # ini
    ''
      include = ~/.cache/hellwal/fuzzel-colors.ini # hellwal

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
  xdg.configFile."networkmanager-dmenu/config.ini".text = # ini
    ''
      [dmenu]
      dmenu_command = fuzzel -d --width 50 --lines 18
      active_chars = >
      wifi_chars = ▂▄▆█
      wifi_icons = 󰤯󰤟󰤢󰤥󰤨
      format = {name:<{max_len_name}}      {icon:1} {signal:2}%%  {sec:<{max_len_sec}}

      [dmenu_passphrase]
      obscure = True

      [editor]
      terminal = kitty
    '';
}
