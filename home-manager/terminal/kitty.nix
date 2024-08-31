{ pkgs, config, ... }:

# Just trying out kitty

{
  programs.kitty = {
    enable = true;
    package = pkgs.unstable.kitty;

    shellIntegration = {
      enableZshIntegration = true;
      mode = "no-cursor";
    };

    settings = {
      cursor_shape = "block";
      cursor_shape_unfocused = "hollow";
      cursor_blink_interval = 0;

      scrollback_lines = 2048;

      bold_font = "${config.stylix.fonts.monospace.name} SemBd";
      bold_italic_font = "${config.stylix.fonts.monospace.name} SemBd Italic";

      focus_follows_mouse = true;

      strip_trailing_spaces = "smart";

      enable_audio_bell = false;

      tab_bar_style = "hidden";

      wayland_enable_ime = true;

      confirm_os_window_close = 0;
    };

    extraConfig = ''
      window_margin_width 0 14
      window_padding_width 0
      scrollback_indicator_opacity 0.5
      mouse_hide_wait -1
    '';
  };

  # HACK: override neovim wrapper terminal
  xdg.desktopEntries.nvim = {
    exec = "kitty nvim %F";
    terminal = false;

    name = "Neovim wrapper";
    genericName = "Text Editor";
    comment = "Edit text files";
    icon = "nvim";
    categories = [ "Utility" "TextEditor" ];
    mimeType = [
      "text/english"
      "text/plain"
      "text/x-makefile"
      "text/x-c++hdr"
      "text/x-c++src"
      "text/x-chdr"
      "text/x-csrc"
      "text/x-java"
      "text/x-moc"
      "text/x-pascal"
      "text/x-tcl"
      "text/x-tex"
      "application/x-shellscript"
      "text/x-c"
      "text/x-c++"
    ];
  };
}
