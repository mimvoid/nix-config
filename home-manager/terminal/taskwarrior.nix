{ pkgs, ... }:

{
  home.packages = with pkgs; [
    taskwarrior-tui
  ];

  programs.taskwarrior = {
    enable = true;
    package = pkgs.unstable.taskwarrior3;

    colorTheme = "dark-16";
    config = {
      default.command = "list";
      confirmation = false;
      recurrence.confirmation = "yes";

      list.all.projects = true;
      list.all.tags = true;
      complete.all.tags = true;

      search.case.sensitive = false;

      calendar.details = "full";
      weekstart = "monday"; 

      fontunderline = false;

      report = {
        list = {
          columns = [ "due" "description" "project" ];
          labels = [ "󰃭" "Task" "Project" ];
        };

        minimal = {
          columns = [ "due" "description" ];
          labels = [ "󰃭" "Task" ];
        };
      };

      uda.taskwarrior-tui = {
        selection.indicator = ">";
        mark.indicator = "";
        unmark.indicator = "●";

        task-report.show-info = false;
      };
    };
    extraConfig = ''
      nag=

      dateformat=D-M
      dateformat.edit=D-M H:N
      dateformat.info=D-M H:N
    '';
  };
}
