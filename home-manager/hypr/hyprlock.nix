{ inputs, config, pkgs, ... }:
let
  lockscreen = "${inputs.wallpapers.outPath}/wallpapers/tokyo-shinjuku.png";
  display = "Limelight";

  palette = pkgs.palettes.current.hex.noHashtag;
  inherit (config.stylix) fonts;
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
          path = lockscreen;
          blur_passes = 0;
        }
      ];

      input-field = [
        {
          size = "256, 48";
          outline_thickness = 1;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;

          outer_color = "rgb(${palette.error})";
          inner_color = "rgb(${palette.base})";

          font_family = fonts.monospace.name;
          font_color = "rgb(${palette.string})";

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
          # Time
          text = ''cmd[update:1000] echo "<big> $(date +'%H:%M') </big>"'';
          color = "rgb(${palette.string})";
          font_family = display;
          font_size = 128;

          position = "0, -220";
          halign = "center";
          valign = "top";
        }
        {
          # Date
          text = ''cmd[update:18000000] echo "$(date +'%A, %B %-d')"'';
          color = "rgb(${palette.string})";
          font_family = fonts.monospace.name;
          font_size = 20;

          position = "0, 90";
          halign = "center";
          valign = "center";
        }
        {
          # User field
          text = "  ${config.home.username}";
          color = "rgb(${palette.string})";
          font_family = fonts.monospace.name;
          font_size = 16;

          position = "0, 8";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
