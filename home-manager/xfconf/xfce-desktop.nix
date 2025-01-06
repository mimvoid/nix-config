{ pkgs, config, ... }:
let
  inherit (pkgs.theme.fonts) monospace;
  inherit (config) gtk;

  homescreen = "${pkgs.xfce.xfdesktop}/share/backgrounds/xfce/xfce-flower.svg";
in
{
  xfconf.settings = {
    xfce4-desktop = pkgs.voids.lib.prependAttrs "backdrop/screen0/monitoreDP-1/" {
      "workspace0/last-image" = homescreen;
      "workspace1/last-image" = homescreen;
      "workspace2/last-image" = homescreen;
      "workspace3/last-image" = homescreen;
    }
    // {
      "desktop-icons/style" = 0; # No desktop icons
    };

    xsettings = {
      "Xft/DPI" = 140;
      "Xfce/LastCustomDPI" = 140;
      "Gtk/FontName" = "${gtk.font.name} 11";
      "Gtk/MonospaceFontName" = "${monospace.name} 12";
      "Gtk/CursorThemeName" = "${gtk.cursorTheme.name}";
      "Gtk/CursorThemeSize" = 38;
    };
  };
}
