{ config, lib, ... }:
let
  panels = with lib.attrsets;
  let
    "position-locked" = true;

    # solid color
    "background-style" = 1;

    # transleucent rose pine moon base
    "background-rgba" = [ (35.0 / 255) (33.0 / 255) (54.0 / 255) 0.75 ];
  in
  {
    top-panel = mapAttrs' (name: value: nameValuePair
      "panels/panel-1/${name}" value)
    {
      # Top panel
      inherit "position-locked" "background-style" "background-rgba";

      "position" = "p=9;x=960;y=18";
      "length" = 98.9;
      "size" = 28;
      "icon-size" = 15;

      # Note: changing the plugin type for a previously used number may not update
      # the plugins' internal names right away, leading to some strange behavior.
      # I found that reloading (e.g. logging out) fixes it.
      "plugin-ids" = lib.lists.range 1 9;
    };

    bottom-panel = mapAttrs' (name: value: nameValuePair
      "panels/panel-2${name}" value)
    {
      inherit "position-locked" "background-style" "background-rgba";

      "autohide-behavior" = 0; # don't autohide
      "position" = "p=0;x=960;y=1050"; # floating
      "length" = 1; # let it be autoexpanded by plugins
      "size" = 46;

      "plugin-ids" = lib.lists.range 10 12;
    };
  };

  plugins = with lib.attrsets; {
    top = mapAttrs' (name: value: nameValuePair
      "plugins/plugin-${name}" value)
    {
      # workspaces
      "1" = "pager";
      "1/rows" = 1;
      "1/numbering" = false;
      "1/miniature-view" = false;
      "1/wrap-workspaces" = true;

      # separator 1
      "2" = "separator";
      "2/expand" = true;
      "2/style" = 0; # transparent

      # clock
      "3" = "clock";
      "3/mode" = 2;
      "3/digital-layout" = 2;
      "3/digital-date-font" = "${config.gtk.font.name} 9";
      "3/digital-date-format" = "%A %b %d  /  %H:%M";

      # separator 2
      "4" = "separator";
      "4/expand" = true;
      "4/style" = 0;

      # systray
      "5" = "systray";
      "5/icon-size" = 0; # automatically size icons
      "5/single-row" = true;
      "5/square-icons" = true; # icons occupy square spaces
      "5/symbolic-icons" = true;

      # audio
      "6" = "pulseaudio";
      "6/volume-max" = 100;

      # notifications
      "7" = "notification-plugin";

      # battery
      "8" = "power-manager-plugin";

      # power
      "9" = "actions";
      "9/appearance" = 1; # Action Buttons = 0, Session Menu = 1
      "9/button-title" = 3; # enable custom title
      "9/custom-title" = "O"; # the letter O
    };
    
    bottom = mapAttrs' (name: value: nameValuePair
      "plugins/plugin-${name}" value)
    {
      # appmenu
      "10" = "applicationsmenu";
      "10/show-button-title" = false;
      "10/button-icon" = "start-here";

      # separator 3
      "11" = "separator";
      "11/expand" = false;
      "11/style" = 0;

      # dock
      "12" = "docklike";
    };
  };
in
{
  xfconf.settings.xfce4-panel = {
    "panels" = [ 1 2 ];
    "panels/dark-mode" = true;
  } // panels.top-panel // panels.bottom-panel // plugins.top // plugins.bottom;

  xdg.configFile."xfce4/panel/docklike-12.rc" = {
    enable = true;
    text = ''
      [user]
      onlyDisplayVisible=false
      onlyDisplayScreen=false
      showPreviews=true
      previewScale=0.5            # default 0.125
      showWindowCount=false
      middleButtonBehavior=2      # do nothing
      noWindowsListIfSingle=false
      indicatorStyle=3            # ciliora
      inactiveIndicatorStyle=1    # dots
      indicatorOrientation=0      # automatic
      forceIconSize=false
      keyComboActive=false
      keyAloneActive=false
      indicatorOrientation=1      # bottom
      indicatorColorFromTheme=false
      indicatorColor=rgb(234,154,151)
      inactiveColor=rgb(62,143,176)
      pinned=kitty;thunar;firefox;krita;
    '';
  };
}
