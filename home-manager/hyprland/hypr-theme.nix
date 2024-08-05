{ config, lib, inputs, ... }:

let
  #homescreen = "${../../wallpapers/bakairis_rainy-world.png}";
  current-palette = ../../palettes/macchiato-nightlight.nix;
  #display = "Limelight";

  hue = config.colorScheme.palette;
  type = config.stylix.fonts;
in
{
  imports = [
    ../theming.nix
    inputs.nix-colors.homeManagerModules.default
    current-palette
  ];

  wayland.windowManager.hyprland.settings = {
    # Homescreen wallpaper
    # HACK: reload Hyprland to exec swww_init_time, adding the script file
    # in exec-once doesn't work
    exec-once = lib.mkAfter [
      "swww-daemon --no-cache &"
      "hyprctl reload config-only &"
    ];
    exec = lib.mkAfter [ "${./swww_init_time.sh} &" ];
    general = {
      "col.active_border" = "rgb(${hue.secAccent})";
      "col.inactive_border" = "rgba(${hue.dullAccent}40)"; # 25% opacity
    };
    decoration."col.shadow" = "rgba(00001933)"; # 20% opacity
  };

  programs.fuzzel.settings = {
    main = {
      font = "${type.monospace.name}:size=9";
    };
    colors = {
      background = "${hue.base}ee";
      text = "${hue.text}ff";
      match = "${hue.mainAccent}ff";
      selection = "${hue.frame}dd";
      selection-match = "${hue.secAccent}ff";
      selection-text = "${hue.paleAccent}ff";
      border = "${hue.watch}ff";
    };
  };
}
