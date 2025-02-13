{ pkgs, lib, ... }:
let
  # Script to use wallpapers at certain times
  # writeShellScript handles the shebang
  swww-schedule = pkgs.writeShellScript "swww-schedule" /* bash */ ''
    case $(date +%H) in
      00 | 01 | 02 | 03 | 04 | 05 | 06) # 0:00 to 6:59, early morning
        swww-daemon ; swww img ${../../wallpapers/wallpapers/gracile_twilight.jpg}
        ;;

      07 | 08 | 09 | 10 | 11) # 7:00 to 11:59, morning
        swww-daemon ; swww img ${../../wallpapers/wallpapers/dangerdrop_coffee-roadtrip.jpg}
        ;;

      12 | 13 | 14 | 15) # 12:00 to 15:59, midday
        swww-daemon ; swww img ${../../wallpapers/wallpapers/dangerdrop_coffee-roadtrip.jpg}
        ;;

      16 | 17 | 18 | 19 | 20) # 16:00 to 19:59, late afternoon/evening
        swww-daemon ; swww img ${../../wallpapers/wallpapers/dangerdrop_coffee-roadtrip.jpg}
        ;;

      21 | 22 | 23) # 21:00 to 23:59, evening/nighttime
        swww-daemon ; swww img ${../../wallpapers/wallpapers/gracile_overgrown.jpg}
        ;;
    esac
  '';
in
{
  home.packages = with pkgs; [ swww ];

  wayland.windowManager.hyprland.settings = {
    exec = lib.mkAfter [ "${swww-schedule} &" ];
  };
}
