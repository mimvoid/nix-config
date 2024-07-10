let
  p1 = "panels/panel-1/";
  p2 = "panels/panel-2/";
  w = {
    workspaces = "plugins/plugin-1";
    sep1 = "plugins/plugin-2";
    clock = "plugins/plugin-3";
    sep2 = "plugins/plugin-4";
    systray = "plugins/plugin-5";
    audio = "plugins/plugin-6";
    notif = "plugins/plugin-7";
    battery = "plugins/plugin-8";
    power = "plugins/plugin-9";

    appmenu = "plugins/plugin-10";
    sep3 = "plugins/plugin-11";
    dock = "plugins/plugin-12";
  };
in
{
  xfconf.settings.xfce4-panel = {
    "panels" = [ 1 2 ];
    "panels/dark-mode" = true;
    
    # Top panel
    "${p1}position" = "p=9;x=960;y=18";
    "${p1}position-locked" = true;
    "${p1}length" = 98.9;
    "${p1}size" = 28;
    "${p1}icon-size" = 15;

    "${p1}background-style" = 1; # solid color
    # transleucent rose pine moon base
    "${p1}background-rgba" = [ (35.0 / 255) (33.0 / 255) (54.0 / 255) 0.75 ];

    # Note: changing the plugin type for a previously used number may not update
    # the plugins' internal names right away, leading to some strange behavior.
    # I found that reloading (e.g. logging out) fixes it.
    "${p1}plugin-ids" = [ 1 2 3 4 5 6 7 8 9 ];
    
    # Bottom panel
    "${p2}autohide-behavior" = 0; # don't autohide
    "${p2}position" = "p=0;x=960;y=1050"; # floating
    "${p2}position-locked" = true;
    "${p2}length" = 1; # let it be autoexpanded by plugins
    "${p2}size" = 46;

    "${p2}background-style" = 1;
    "${p2}background-rgba" = [ (35.0 / 255) (33.0 / 255) (54.0 / 255) 0.75 ];

    "${p2}plugin-ids" = [ 10 11 12 ];

    # Plugins/widgets
    # Top bar
    "${w.workspaces}" = "pager";
    "${w.workspaces}/rows" = 1;
    "${w.workspaces}/numbering" = false;
    "${w.workspaces}/miniature-view" = false;
    "${w.workspaces}/wrap-workspaces" = true;

    "${w.sep1}" = "separator";
    "${w.sep1}/expand" = true;
    "${w.sep1}/style" = 0; # transparent

    "${w.clock}" = "clock";
    "${w.clock}/mode" = 2;
    "${w.clock}/digital-layout" = 2;
    "${w.clock}/digital-date-font" = "Cantarell 9";
    "${w.clock}/digital-date-format" = "%A %b %d  /  %H:%M";

    "${w.sep2}" = "separator";
    "${w.sep2}/expand" = true;
    "${w.sep2}/style" = 0;

    "${w.systray}" = "systray";
    "${w.systray}/icon-size" = 0; # automatically size icons
    "${w.systray}/single-row" = true;
    "${w.systray}/square-icons" = true; # icons occupy square spaces
    "${w.systray}/symbolic-icons" = true;

    "${w.audio}" = "pulseaudio";
    "${w.audio}/volume-max" = 100;

    "${w.notif}" = "notification-plugin";

    "${w.battery}" = "power-manager-plugin";

    "${w.power}" = "actions";
    "${w.power}/appearance" = 1; # Action Buttons = 0, Session Menu = 1
    "${w.power}/button-title" = 3; # enable custom title
    "${w.power}/custom-title" = "O"; # the letter O

    # Bottom bar
    "${w.appmenu}" = "applicationsmenu";
    "${w.appmenu}/show-button-title" = false;
    "${w.appmenu}/button-icon" = "start-here";

    "${w.sep3}" = "separator";
    "${w.sep3}/expand" = false;
    "${w.sep3}/style" = 0;

    "${w.dock}" = "docklike";
  };

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
      pinned=xterm;thunar;firefox;krita;
    '';
  };
}
