let
  #p1 = "/panels/panel-1/";
  #p2 = "/panels/panel-2/";
  w = {
    appmenu = "plugins/plugin-1";
    tasks = "plugins/plugin-2";
    sep1 = "plugins/plugin-3";
    workspaces = "plugins/plugin-4";
    five = "plugins/plugin-5";
    six = "plugins/plugin-6";
    seven = "plugins/plugin-7";
    eight = "plugins/plugin-8";
    nine = "plugins/plugin-9";
    ten = "plugins/plugin-10";
  };
in
{
  xfconf.settings.xfce4-panel = {
    # Does this module handle arrays?
    
    # Top panel
    #"${p1}position" = "p=6;x=0;y=0";
    #"${p1}position-locked" = true;
    #"${p1}plugin-ids" = [ 4 3 5 6 9 10 11 12 13 14 ];
    
    # Bottom panel
    #"${p2}position" = "p=10;x=0;y=0";
    #"${p2}position-locked" = true;
    #"${p2}plugin-ids" = [ 1 15 16 17 18 19 20 21 22 2 ];

    # Plugins/widgets
    "${w.appmenu}" = "applicationsmenu";
    "${w.appmenu}/show-button-title" = false;
    "${w.appmenu}/button-title" = "view-list-details";

    "${w.tasks}" = "tasklist";
    "${w.tasks}/grouping" = 1;
    "${w.tasks}/show-labels" = false;
    "${w.tasks}/show-handle" = false;
    "${w.tasks}/flat-buttons" = true;
    "${w.tasks}/show-tooltips" = true;
    
    "${w.sep1}" = "separator";
    "${w.sep1}/expand" = true;
    "${w.sep1}/style" = 0;

    "${w.workspaces}" = "pager";
    "${w.workspaces}/rows" = 1;
    "${w.workspaces}/miniature-view" = false;
    "${w.workspaces}/numbering" = false;
    "${w.workspaces}/wrap-workspaces" = true;
    "${w.workspaces}/workspace-scrolling" = true;
  };
}
