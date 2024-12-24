{ pkgs, ... }:
let
  inherit (pkgs.my-utils) prependAttrs;

  commands = {
    custom = prependAttrs "commands/custom/<Super>" {
      "Return" = "exo-open --launch TerminalEmulator";
      "w" = "exo-open --launch WebBrowser";
      "e" = "thunar";
      "space" = "xfce4-appfinder";
      "o" = "obsidian";
      "d" = "kitty dooit";
      "a" = "krita";

      "<Shift>q" = "xfce4-session-logout";
    };

    wm = prependAttrs "xfwm4/custom/<Super>" {
      "q" = "close_window_key";

      "m" = "maximize_window_key";
      "f" = "fullscreen_key";

      "1" = "workspace_1_key";
      "2" = "workspace_2_key";
      "3" = "workspace_3_key";
      "4" = "workspace_4_key";

      "<Shift>1" = "move_window_workspace_1_key";
      "<Shift>2" = "move_window_workspace_2_key";
      "<Shift>3" = "move_window_workspace_3_key";
      "<Shift>4" = "move_window_workspace_4_key";
    };
  };
in
{
  xfconf.settings.xfce4-keyboard-shortcuts = commands.custom // commands.wm;
}
