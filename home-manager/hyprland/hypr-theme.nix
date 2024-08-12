{ config, lib, ... }:

let
  pal = config.palette;
  type = config.stylix.fonts;
in
{
  imports = [
    ../theming.nix
    ../../palettes/palette.nix
  ];

  wayland.windowManager.hyprland.settings = {
    # Homescreen wallpaper
    exec-once = lib.mkAfter [ "swww-daemon --no-cache &" ];
    exec = lib.mkAfter [ "${./swww_init_time.sh} &" ];
    general = {
      "col.active_border" = "rgb(${pal.primary})";
      "col.inactive_border" = "rgba(${pal.primary-dim}40)"; # 25% opacity
    };
    decoration."col.shadow" = "rgba(${pal.shadow}33)"; # 20% opacity
  };

  programs.fuzzel.settings = {
    main = {
      font = "${type.monospace.name}:size=9";
    };
    colors = {
      background = "${pal.base}ee";
      text = "${pal.string}ff";
      match = "${pal.secondary}ff";
      selection = "${pal.box-bright}dd";
      selection-match = "${pal.primary}ff";
      selection-text = "${pal.secondary-bright}ff";
      border = "${pal.error}ff";
    };
  };
}
