let
  p1 = "panels/panel-1/";
  p2 = "panels/panel-2/";
  w = {
    workspaces = "plugins/plugin-1";
    sep1 = "plugins/plugin-2";
    clock = "plugins/plugin-3";
    sep2 = "plugins/plugin-4";
    systray = "plugins/plugin-5";
    notif = "plugins/plugin-6";
    battery = "plugins/plugin-7";
    power = "plugins/plugin-8";

    appmenu = "plugins/plugin-9";
    sep3 = "plugins/plugin-10";
    dock = "plugins/plugin-11";
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
    "${p1}icon-size" = 16;

    "${p1}background-style" = 1; # solid color
    # transleucent catppuccin macchiato base
    "${p1}background-rgba" = [
      0.14117647058823529
      0.15294117647058827
      0.22745098039215686
      0.72390572390572394
    ];
    # Note: changing the order may not update the plugins'
    # internal names right away, leading to some strange behavior.
    # I've found that reloading the XFCE shell (e.g. logging out) fixes it.
    "${p1}plugin-ids" = [ 1 2 3 4 5 6 7 8 ];
    
    # Bottom panel
    "${p2}autohide-behavior" = 0; # don't autohide
    "${p2}position" = "p=10;x=968;y=1056";
    "${p2}position-locked" = true;
    "${p2}length" = 1; # let it be autoexpanded by plugins
    "${p2}size" = 42;

    "${p2}background-style" = 1; # solid color
    "${p2}background-rgba" = [
      0.14117647058823529
      0.15294117647058827
      0.22745098039215686
      0.72390572390572394
    ];
    "${p2}plugin-ids" = [ 9 10 11 12 13 14 15 16 ];

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
    "${w.clock}/digital-date-font" = "Cantarell 8";
    "${w.clock}/digital-date-format" = "%A %b %d / %H:%M";

    "${w.sep2}" = "separator";
    "${w.sep2}/expand" = true;
    "${w.sep2}/style" = 0;

    "${w.systray}" = "systray";
    "${w.systray}/icon-size" = 0; # automatically size icons
    "${w.systray}/single-row" = true;
    "${w.systray}/square-icons" = true; # icons occupy square spaces
    "${w.systray}/symbolic-icons" = true;

    "${w.notif}" = "notification-plugin";

    "${w.battery}" = "power-manager-plugin";

    "${w.power}" = "actions";
    "${w.power}/appearance" = 1; # Action Buttons = 0, Session Menu = 1
    "${w.power}/button-title" = 3; # enable custom title
    "${w.power}/custom-title" = "O"; # the letter O

    # Bottom bar
    "${w.appmenu}" = "applicationsmenu";
    "${w.appmenu}/show-button-title" = false;
    "${w.appmenu}/button-icon" = "view-list-details";

    "${w.sep3}" = "separator";
    "${w.sep3}/expand" = false;
    "${w.sep3}/style" = 0;

    "${w.dock}" = "docklike";
  };

  xdg.configFile."xfce4/panel/docklike-11.rc" = {
    enable = true;
    text = ''
      [user]
      onlyDisplayVisible=false
      onlyDisplayScreen=false
      showPreviews=true
      showWindowCount=false
      middleButtonBehavior=2 # do nothing
      noWindowsListIfSingle=false
      indicatorStyle=3 # ciliora
      inactiveIndicatorStyle=1 # dots
      indicatorOrientation=0 # automatic
      indicatorColorFromTheme=true
      forceIconSize=false
      keyComboActive=false
      keyAloneActive=false
      pinned=xterm;thunar;firefox;krita;
    '';
  };
}
