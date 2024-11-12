{
  pkgs,
  config,
  lib,
  ...
}:

let
  pal = config.palette;
  type = config.stylix.fonts;

  wallpapers = "${config.home.homeDirectory}/NixOS/wallpapers/wallpapers";

  swww-schedule =
    pkgs.writeShellScript "swww-schedule" # bash
      ''
        case $(date +%H) in
          00 | 01 | 02 | 03 | 04 | 05 | 06) # 0:00 to 6:59, early morning

            swww-daemon ; swww img ${wallpapers}/gracile_twilight.jpg
            ;;
          07 | 08 | 09 | 10 | 11) # 7:00 to 11:59, morning

            swww-daemon ; swww img ${wallpapers}/dangerdrop_coffee-roadtrip.jpg
            ;;
          12 | 13 | 14 | 15) # 12:00 to 15:59, midday

            swww-daemon ; swww img ${wallpapers}/dangerdrop_coffee-roadtrip.jpg
            ;;
          16 | 17 | 18 | 19 | 20) # 16:00 to 19:59, late afternoon/evening

            swww-daemon ; swww img ${wallpapers}/dangerdrop_coffee-roadtrip.jpg
            ;;
          21 | 22 | 23) # 21:00 to 23:59, evening/nighttime

            swww-daemon ; swww img ${wallpapers}/gracile_overgrown.jpg
            ;;
        esac
      '';
in
{
  wayland.windowManager.hyprland.settings = {
    # Homescreen wallpaper
    exec = lib.mkAfter [ "${swww-schedule} &" ];

    general = with pal; {
      "col.active_border" = "rgb(${primary})";
      "col.inactive_border" = "rgba(${primary-dim}40)"; # 25% opacity
    };
    decoration."col.shadow" = "rgba(${pal.shadow}33)"; # 20% opacity
  };

  programs.fuzzel.settings = {
    main.font = "${type.monospace.name}:size=9";

    colors = with pal;
      {
        background = base + "ee";
        text = string + "ff";
        match = secondary + "ff";
        selection = box-bright + "dd";
        selection-match = primary + "ff";
        selection-text = secondary-bright + "ff";
        border = error + "ff";
      };
  };
}
