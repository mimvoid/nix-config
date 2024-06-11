{ pkgs, ... }:
let
  homescreen = "${pkgs.xfce.xfdesktop}/share/backgrounds/xfce/xfce-flower.svg";
in
{
  xfconf.settings.xfce4-desktop = {
    "backdrop/screen0/monitordDP-1/workspace0/last-image" = homescreen;
    "backdrop/screen0/monitordDP-1/workspace1/last-image" = homescreen;
    "backdrop/screen0/monitordDP-1/workspace2/last-image" = homescreen;
    "backdrop/screen0/monitordDP-1/workspace3/last-image" = homescreen;
  };
}
