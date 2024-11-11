{ config, lib, ... }:
let
  prependAttrs = prefix:
    lib.attrsets.mapAttrs' (name: value:
      lib.nameValuePair "${prefix}${name}" value);
in
{
  xfconf.settings.xfwm4 = prependAttrs "general/" {
    "theme" = "rose-pine-moon";

    # Focus
    "click_to_focus" = false; # enables follow mouse focus
    "focus_new" = true;
    "prevent_focus_stealing" = false;
    "raise_on_click" = true;
    "raise_on_focus" = true;

    # Opacity
    "frame_opacity" = 80;
    "move_opacity" = 85;
    "resize_opacity" = 85;
    "inactive_opacity" = 75;
    "popup_opacity" = 95;
    "shadow_opacity" = 50;

    # Window title & buttons

    # Default: "O|SHMC" Icon | Shutter Hide Maximize Close
    "button_layout" = "|SHMC";
    "title_font" = "${config.gtk.font.name} 9";

    "borderless_maximize" = true;
    "titleless_maximize" = true;

    # Workspaces
    "cycle_workspaces" = true;
    "scroll_workspaces" = true;

    # Snapping
    "tile_on_move" = true;
    "snap_resist" = false;
    "snap_to_border" = true;
    "snap_to_windows" = true;
    "snap_width" = 64;

    # Workspaces
    "workspace_names" = [
      "1"
      "2"
      "3"
      "4"
    ];
    # disables the mouse changing workspaces at the edge of a screen
    "wrap_workspaces" = false;

    # Margins
    # The large top and bottom margins allow exclusive space for
    # the panels, even if they are floating
    "margin_top" = 35;
    "margin_right" = 12;
    "margin_bottom" = 60;
    "margin_left" = 12;

    # Cycling
    "cycle_draw_frame" = false;
    "cycle_minimized" = true;
    "cycle_raise" = true;
  };
}
