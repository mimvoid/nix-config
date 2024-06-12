{ pkgs, ... }:
let
  homescreen = "${pkgs.xfce.xfdesktop}/share/backgrounds/xfce/xfce-leaves.svg";
in
{
  xfconf.settings = {
    xfce4-desktop = {
      "backdrop/screen0/monitoreDP-1/workspace0/last-image" = homescreen;
      "backdrop/screen0/monitoreDP-1/workspace1/last-image" = homescreen;
      "backdrop/screen0/monitoreDP-1/workspace2/last-image" = homescreen;
      "backdrop/screen0/monitoreDP-1/workspace3/last-image" = homescreen;
      "desktop-icons/style" = 0; # No desktop icons
    };
    xsettings = {
      "Xft/DPI" = 144;
      "Xfce/LastCustomDPI" = 144;
      "Gtk/FontName" = "Cantarell 11";
      "Gtk/MonospaceFontName" = "SauceCodePro Nerd Font 12";
    };
  };
}
