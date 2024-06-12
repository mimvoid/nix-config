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

    # Opacity
    "${g}frame_opacity" = 85;
    "${g}move_opacity" = 85;
    "${g}resize_opacity" = 85;
    "${g}inactive_opacity" = 75;
    "${g}popup_opacity" = 95;
    "${g}shadow_opacity" = 50;

    # Window title & buttons
    
    # Default: "O|SHMC" Icon | Shutter Hide Min/Maximize Close
    "${g}button_layout" = "|SHMC";
    "${g}title_font" = "Cantarell 9";
    "${g}borderless_maximize" = true;

    # Workspaces
    "${g}cycle_workspaces" = true;
    "${g}scroll_workspaces" = true;
    
    # Snapping
    "${g}snap_resist" = false;
    "${g}snap_to_border" = true;
    "${g}snap_to_windows" = true;
    "${g}snap_width" = 64;

    # Workspaces
    "${g}worksapce_names" = [ "1" "2" "3" "4" ];
    
    # Margins
    "${g}margin_top" = 12;
    "${g}margin_right" = 12;
    "${g}margin_bottom" = 12;
    "${g}margin_left" = 12;
  };
}
