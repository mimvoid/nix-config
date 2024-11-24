{ pkgs, config, ... }:

{
  programs.kitty = {
    enable = true;
    package = pkgs.unstable.kitty;

    shellIntegration = {
      enableZshIntegration = true;
      mode = "no-cursor";
    };

    font = with config.stylix.fonts; {
      inherit (monospace) name package;
      size = sizes.terminal;
    };

    settings =
      let
        colors = with config.lib.stylix.colors.withHashtag; rec {
          foreground = base06;
          background = base00;
          selection_background = base0F;

          # black
          color0 = base01;
          color8 = base02;

          color1 = red;
          color2 = green;
          color3 = yellow;
          color4 = blue;
          color5 = magenta;
          color6 = cyan;

          # white
          color7 = base03;
          color15 = base04;

          color9 = color1;
          color10 = color2;
          color11 = color3;
          color12 = color4;
          color13 = color5;
          color14 = color6;
        };

        color-usages = with colors; {
          active_border_color = color3;
          inactive_border_color = color7;
          url_color = color2;

          cursor = "none"; # colored with the text underneath
          cursor_text_color = "background"; # fg colored with terminal background
          selection_foreground = "none";
        };

        inherit (config.stylix.fonts) monospace;
      in
      {
        # Bold font
        bold_font = "${monospace.name} SemBd";
        bold_italic_font = "${monospace.name} SemBd Italic";

        # Windows
        inactive_text_alpha = 0.75;
        focus_follows_mouse = true;

        # Cursor
        disable_ligatures = "cursor";
        cursor_shape = "block";
        cursor_shape_unfocused = "hollow";
        cursor_blink_interval = 0;

        # Misc
        scrollback_lines = 2048;
        strip_trailing_spaces = "smart";
        enable_audio_bell = false;
        tab_bar_style = "hidden";
        confirm_os_window_close = 0;
      }
      // colors // color-usages;

    keybindings = {
      "ctrl+alt+enter" = "launch --cwd=current";
    };

    extraConfig = ''
      window_margin_width 0
      window_padding_width 0 14
      scrollback_indicator_opacity 0.5
      mouse_hide_wait -1
    '';
  };
}
