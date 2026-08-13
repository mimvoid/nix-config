{
  programs.bat = {
    enable = true;
    config.theme = "ansi";
  };

  programs.lesspipe.enable = true;

  home.sessionVariables = {
    # pagers
    PAGER = "less";
    LESS = builtins.concatStringsSep " " [
      "--ignore-case"
      "--status-column"
      "--use-color"
      "--quit-if-one-screen"
      "--no-init"
      "--window=-4"
      "--HILITE-UNREAD"
      "--RAW-CONTROL-CHARS" # highlighting with lesspipe
    ];
    BAT_STYLE = "numbers,changes";
    MANPAGER = "nvim +Man!";
  };
}
