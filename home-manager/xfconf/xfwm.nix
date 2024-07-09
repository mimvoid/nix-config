let
  g = "general/";
in
{
  xfconf.settings.xfwm4 = {
    "${g}theme" = "rose-pine-moon";

    # Focus
    "${g}click_to_focus" = false; # enables follow mouse focus
    "${g}focus_new" = true;
    "${g}prevent_focus_stealing" = false;
    "${g}raise_on_click" = true;
    "${g}raies_on_focus" = true;

    # Opacity
    "${g}frame_opacity" = 80;
    "${g}move_opacity" = 85;
    "${g}resize_opacity" = 85;
    "${g}inactive_opacity" = 75;
    "${g}popup_opacity" = 95;
    "${g}shadow_opacity" = 50;

    # Window title & buttons
    
    # Default: "O|SHMC" Icon | Shutter Hide Maximize Close
    "${g}button_layout" = "|SHMC";
    "${g}title_font" = "Cantarell 9";

    # used with picom, default compositor includes shadows in borders
    "${g}borderless_maximize" = false;

    # Workspaces
    "${g}cycle_workspaces" = true;
    "${g}scroll_workspaces" = true;
    
    # Snapping
    "${g}tile_on_move" = true;
    "${g}snap_resist" = false;
    "${g}snap_to_border" = true;
    "${g}snap_to_windows" = true;
    "${g}snap_width" = 64;

    # Workspaces
    "${g}workspace_names" = [ "1" "2" "3" "4" ];
    # disables the mouse changing workspaces at the edge of a screen
    "${g}wrap_workspaces" = false;     
    
    # Margins
    "${g}margin_top" = 12;
    "${g}margin_right" = 12;
    "${g}margin_bottom" = 12;
    "${g}margin_left" = 12;
  };
}
