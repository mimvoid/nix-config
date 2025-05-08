{ pkgs, ... }:

{
  home.packages = with pkgs; [ unstable.matugen ];

  xdg.configFile."matugen/config.toml".text =
    let
      inherit (pkgs.palettes.moonfall-eve.hex.default)
        base00
        base01
        base02
        base03
        base04
        base05
        red
        green
        yellow
        blue
        cyan
        magenta
        ;
    in
    # toml
    ''
      [config.wallpaper]
      command = "swww"
      arguments = ["img", "-t", "grow", "--transition-pos", "0.95,0.95", "--transition-step", "90"]
      set = true

      [config.custom_colors]
      bg = "${base00}"
      base01 = "${base01}"
      base02 = "${base02}"
      base03 = "${base03}"
      base04 = "${base04}"
      fg = "${base05}"
      red = "${red}"
      green = "${green}"
      yellow = "${yellow}"
      blue = "${blue}"
      cyan = "${cyan}"
      magenta = "${magenta}"

      [templates.astal]
      input_path = '${./templates/astal.scss}'
      output_path = '~/.config/ags/style/palette/_matugen.scss'

      [templates.hyprland]
      input_path = '${./templates/hyprland-colors.conf}'
      output_path = '~/.config/hypr/colors.conf'
      post_hook = 'hyprctl reload'

      [templates.kitty]
      input_path = '${./templates/kitty-colors.conf}'
      output_path = '~/.config/kitty/colors.conf'
      post_hook = 'kitty @ set-colors -a -c ~/.config/kitty/colors.conf'

      [templates.fuzzel]
      input_path = '${./templates/fuzzel-colors.ini}'
      output_path = '~/.config/fuzzel/colors.ini'

      [templates.pywalfox]
      input_path = '${./templates/pywalfox.json}'
      output_path = '~/.cache/wal/colors.json'

      # [templates.css]
      # input_path = '${./templates/colors.css}'
      # output_path = '~/.cache/matugen/colors.css'
      #
      # [templates.scss]
      # input_path = '${./templates/colors.scss}'
      # output_path = '~/.cache/matugen/colors.scss'
    '';
}
