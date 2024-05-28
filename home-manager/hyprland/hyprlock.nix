{ outputs, ... }:
let
  monospace = "SauceCodePro Nerd Font";
  display = "Limelight";
in
{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        grace = 2;
        disable_loading_bar = true;
        hide_cursor = false;
        no_face_in = false;
      };

      background = [
        {
        # monitor =
        path = "../../wallpapers/Buildings.png";
        color = "rgb(ee99a0)";# maroon
        blur_passes = 0;
        }
      ];

      input-field = [
        {
          # monitor =
          size = "256, 48";
          outline_thickness = 1;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;

          outer_color = "rgb(ee99a0)"; # maroon
          inner_color = "rgb(24273a)"; # base

          font_family = monospace;
          font_color = "rgb(cad3f5)"; # text
          placeholder_text = "<i>Password...</i>";
          hide_input = false;

          fade_on_empty = true;

          position = "0, -42";
          halign = "center";
          valign = "center";
        }
      ];

      label = [
        {
          # Date
          # monitor =
          text = "cmd[update:18000000] echo '$(date +'%A, %B %-d')'";
          color = "rgb(cad3f5)"; # text
          font_size = 20;
          font_family = monospace;

          position = "0, 90";
          halign = "center";
          valign = "center";
        }
        {
          # Time
          # monitor =
          text = "cmd[update:1000] echo '<big> $(date +'%H:%M') </big>'";
          color = "rgb(cad3f5)"; # text
          font_size = 128;
          font_family = monospace; # Replace with display eventually

          position = "0, -220";
          halign = "center";
          valign = "top";
        }
        {
          # User field
          # monitor =
          text = "  welcome!"; # Will put a username variable here sometime
          color = "rgb(cad3f5)"; # text
          font_size = 16;
          font_family = monospace;

          position = "0, 12";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
