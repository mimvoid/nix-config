{ pkgs, ... }:

{
  home.packages = [ (pkgs.callPackage ../../packages/cortile.nix {}) ];

  xdg.configFile."cortile/config.toml" = {
    enable = true;
    text = # toml
    ''
      # Tiling

      tiling_enabled = true
      tiling_layout = "vertical-left"

      tiling_gui = 0

      # Menu entries in systray which shows the tiling state as icon ([] = disabled).
      # tiling_icon = [
      #   ["ACTION", "TEXT"] = ["action strings from [keys] section", "text to show in the menu"],
      #   ["", ""] = "show a separator line",
      # ]
      tiling_icon = [
        ["toggle", "Enabled"],
        ["", ""],
        ["master_increase", "Add Master"],
        ["master_decrease", "Remove Master"],
        ["", ""],
        ["slave_increase", "Add Slave"],
        ["slave_decrease", "Remove Slave"],
        ["", ""],
        ["reset", "Reset"],
        ["exit", "Exit"],
      ]

      # Window

      # Find with `xprop WM_CLASS`
      # window_ignore = [
      #   ["WM_CLASS", "WM_NAME"] = ["ignore windows w/ this class", "but allow those w/ this name"]
      # ]
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

      # Edge

      edge_margin = [4, 4, 56, 4]
      edge_margin_primary = [4, 4, 56, 4]

      edge_corner_size = 0
      edge_center_size = 0

      ################################################################################
      [colors]                             # RGBA color values used for ui elements. #
      ################################################################################

      # Layout window
      gui_text = [255, 255, 255, 255]
      gui_background = [30, 30, 40, 255]

      # Layout slave client rectangle color.
      gui_client_slave = [58, 58, 78, 255]

      # Layout master client rectangle color.
      gui_client_master = [98, 98, 128, 255]

      # Systray icon background color.
      icon_background = [0, 0, 0, 0]

      # Systray icon foreground color.
      icon_foreground = [255, 255, 255, 255]

      ################################################################################
      [keys]                            # Key symbols can be found by running `xev`. #
      ################################################################################

      # Enable/disable tiling on current screen
      enable = "Control-Shift-Home"
      disable = "Control-Shift-End"

      toggle = "Control-T"

      # Disable tiling and restore windows on the current screen.
      restore = "Control-Shift-R"

      # Layouts
      reset = "Control-R"

      cycle_next = "Control-Shift-K"
      cycle_previous = "Control-Shift-J"

      layout_vertical_left = "Control-Shift-Left"
      layout_vertical_right = "Control-Shift-Right"
      layout_horizontal_top = "Control-Shift-Up"
      layout_horizontal_bottom = "Control-Shift-Down"
      layout_maximized = "Control-Shift-M"
      layout_fullscreen = "Control-Shift-F"

      # Windows

      master_make = "Control-M"
      master_make_next = "Control-Shift-KP_6"
      master_make_previous = "Control-Shift-KP_4"

      master_increase = "Control-Shift-KP_Add"
      master_decrease = "Control-Shift-KP_Subtract"

      slave_increase = "Control-Shift-Plus"
      slave_decrease = "Control-Shift-Minus"

      proportion_increase = "Control-Mod1-K"
      proportion_decrease = "Control-Mod1-J"

      # Window focus
      window_next = "Control-K"
      window_previous = "Control-J"

      # Commands affect all screens (Mod1 = Alt_L).
      mod_screens = ""

      # Commands affect all workspaces (Mod4 = Control).
      mod_workspaces = ""

      [corners]

      top_left = ""
      top_center = ""
      top_right = ""

      center_left = ""
      center_right = ""

      bottom_right = ""
      bottom_center = ""
      bottom_left = ""

      [systray]

      click_left = ""
      click_middle = "toggle"
      click_right = ""

      scroll_up = ""
      scroll_down = ""
      scroll_left = ""
      scroll_right = ""
    '';
  };
}
