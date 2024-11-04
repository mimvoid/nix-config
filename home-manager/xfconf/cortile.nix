{ pkgs, ... }:
let
  cortile = pkgs.callPackage ../../packages/cortile.nix {  };
in
{
  home.packages = [ cortile ];

  xdg.configFile."cortile/config.toml" = {
    enable = true;
    text = # toml
    ''
      # Tiling
      tiling_enabled = true
      tiling_layout = "vertical-left"

      # Disable overlay window when switching layouts
      tiling_gui = 0

      # Window
      window_ignore = [
        ["nm.*", ""],
        ["gcr.*", ""],
        ["polkit.*", ""],
        ["wrapper.*", ""],
        ["lightdm.*", ""],
        ["blueman.*", ""],
        ["pavucontrol.*", ""],
        ["firefox.*", ".*Mozilla Firefox"],
        ["xfce4-appfinder", ""],
      ]

      window_masters_max = 3
      window_slaves_max = 2

      window_gap_size = 10
      window_decoration = true

      # Proportions
      proportion_step = 0.01
      proportion_min = 0.2

      # Margin edges
      edge_margin = [4, 4, 56, 4]
      edge_margin_primary = [4, 4, 56, 4]

      # Hot corner areas
      edge_corner_size = 0
      edge_center_size = 0

      [keys]
      # Key symbols can be found by running `xev`

      # Layouts
      reset = "Control-R"

      cycle_next = "Control-Shift-K"
      cycle_previous = "Control-Shift-J"

      layout_maximized = "Control-Shift-M"
      layout_fullscreen = "Control-Shift-F"

      # Windows
      master_make = "Control-M"

      proportion_increase = "Control-Mod1-K" # Ctrl+Alt
      proportion_decrease = "Control-Mod1-J"

      # Focus
      window_next = "Control-K"
      window_previous = "Control-J"

      mod_screens = ""
      mod_workspaces = ""

      [corners]
      top_left = ""
      top_right = ""
      bottom_right = ""
      bottom_left = ""

      [systray]
      scroll_up = ""
      scroll_down = ""
      scroll_left = ""
      scroll_right = ""
    '';
  };
}
