let
  c = "commands/custom/";
  wm = "xfwm4/custom/";
in
{
  xfconf.settings.xfce4-keyboard-shortcuts = {
    "${c}<Super>Return" = "exo-open --launch TerminalEmulator";
    "${c}<Super>w" = "exo-open --launch WebBrowser";
    "${c}<Super>e" = "thunar";

    "${c}<Super><Shift>q" = "xfce4-session-logout";
    "${wm}<Super>q" = "close_window_key";

    "${wm}<Super>1" = "workspace_1_key";
    "${wm}<Super>2" = "workspace_2_key";
    "${wm}<Super>3" = "workspace_3_key";
    "${wm}<Super>4" = "workspace_4_key";

    "${wm}<Super><Shift>1" = "move_window_workspace_1_key";
    "${wm}<Super><Shift>2" = "move_window_workspace_2_key";
    "${wm}<Super><Shift>3" = "move_window_workspace_3_key";
    "${wm}<Super><Shift>4" = "move_window_workspace_4_key";
  };
}
