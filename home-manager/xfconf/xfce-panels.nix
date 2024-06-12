let
  #p1 = "panel-1/";
  #p2 = "panel-2/";
  w = {
    workspaces = "plugins/plugin-1";
    sep1 = "plugins/plugin-2";
    sep2 = "plugins/plugin-3";
    clock = "plugins/plugin-4";
    systray = "plugins/plugin-5";
    notif = "plugins/plugin-6";
    battery = "plugins/plugin-7";
    power = "plugins/plugin-8";
  };
in
{
  xfconf.settings.xfce4-panel = {
    # TODO: panel settings are very messy

    #"panels" = [{
    #  # Top panel
    #  "${p1}position" = "p=6;x=0;y=0";
    #  "${p1}position-locked" = true;
    #  "${p1}plugin-ids" = [ 4 3 5 6 9 10 11 12 13 14 ];
    
    #  # Bottom panel
    #  "${p2}position" = "p=10;x=0;y=0";
    #  "${p2}position-locked" = true;
    #  "${p2}plugin-ids" = [ 1 15 16 17 18 19 20 21 22 2 ];
    #}];

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
    "${w.power}/button-title" = 3; # enable custom title
    "${w.power}/custom-title" = "O"; # the letter O

    # Bottom bar
    #"${w.appmenu}" = "applicationsmenu";
    #"${w.appmenu}/show-button-title" = false;
    #"${w.appmenu}/button-title" = "view-list-details";

    #"${w.tasks}" = "tasklist";
    #"${w.tasks}/grouping" = 1;
    #"${w.tasks}/show-labels" = false;
    #"${w.tasks}/show-handle" = false;
    #"${w.tasks}/flat-buttons" = true;
    #"${w.tasks}/show-tooltips" = true;
  };
}
