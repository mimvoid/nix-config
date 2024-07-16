{ config, inputs, ... }:

# Ideally, the colors and fonts should be in
# hypr-theme.nix, but extracting and appending
# an attribute set within a list is complicated.
# This is a temporary solution.

let
  # Cannot be a relative path since it's pointing to a file
  # that's untracked due to being inside a git submodule
  lockscreen = "~/NixOS/wallpapers/wallpapers/tokyo-shinjuku.png";
  current-palette = ../../palettes/macchiato-nightlight.nix;
  display = "Limelight";

  hue = config.colorScheme.palette;
  type = config.stylix.fonts;
in
{
  imports = [
    ../theming.nix
    inputs.nix-colors.homeManagerModules.default
    current-palette
  ];

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

          outer_color = "rgb(${hue.watch})";
          inner_color = "rgb(${hue.base})";

          font_family = type.monospace.name;
          font_color = "rgb(${hue.text})";

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
          color = "rgb(${hue.text})";
          font_family = display;
          font_size = 128;

          position = "0, -220";
          halign = "center";
          valign = "top";
        }
        {
          # Date
          text = ''cmd[update:18000000] echo "$(date +'%A, %B %-d')"'';
          color = "rgb(${hue.text})"; # text
          font_family = type.monospace.name;
          font_size = 20;

          position = "0, 90";
          halign = "center";
          valign = "center";
        }
        {
          # User field
          text = "  ${config.home.username}";
          color = "rgb(${hue.text})";
          font_family = type.monospace.name;
          font_size = 16;

          position = "0, 8";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
