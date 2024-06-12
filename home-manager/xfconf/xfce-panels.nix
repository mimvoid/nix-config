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

    #appmenu = 
    #sep3 = 
    #launch-term = 
    #launch-files = 
    #launch-browser = 
    #launch-appfind = 
    #sep4 =
    #tasks = 
  };
in
{
  xfconf.settings.xfce4-panel = {
    # TODO: panel settings are very messy

    #"panels" = [
    #1 # for panel 1
    #2 # for panel 2
    #{ dark-mode = true; }
    #{
    #  # Top panel
    #  "${p1}position" = "p=6;x=0;y=0";
    #  "${p1}position-locked" = true;
    #  "${p1}length" = 98.9;
    #  "${p1}size" = 28;
    #  "${p1}plugin-ids" = [ 1 2 4 3 5 6 7 8 ];
    #}
    #{
    #  # Bottom panel
    #  "${p2}autohide-behavior" = 0; # don't autohide
    #  "${p2}position" = "p=10;x=0;y=0";
    #  "${p2}position-locked" = true;
    #  "${p2}length" = 1; # let it be autoexpanded by plugins
    #  "${p2}size" = 42;
    #  "${p2}plugin-ids" = [  ];
    #}
    #];

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

    #"${w.sep3}" = "separator";
    #"${w.sep3}/expand" = false;
    #"${w.sep3}/style" = 

    #"${w.launch-term}" = "launcher";
    #"${w.launch-term}/items" = ["17181307541.desktop"];

    #"${w.launch-files}" = "launcher";
    #"${w.launch-files}/items" = ["17181307542.desktop"];

    #"${w.launch-browser}" = "launcher";
    #"${w.launch-browser}/items" = ["17181307543.desktop"];

    #"${w.launch-appfind}" = "launcher";
    #"${w.launch-appfind}/items" = ["17181307544.desktop"];

    #"${w.sep4}" = separator;
    #"${w.sep4}/expand" = false;
    #"${w.sep4}/style" = 0;

    #"${w.tasks}" = "tasklist";
    #"${w.tasks}/grouping" = 1;
    #"${w.tasks}/show-labels" = false;
    #"${w.tasks}/show-handle" = false;
    #"${w.tasks}/flat-buttons" = true;
    #"${w.tasks}/show-tooltips" = true;
  };
}
