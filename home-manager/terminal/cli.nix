{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # media
    imagemagick
    exiftool
    mediainfo
    fontpreview

    # disk & files
    trashy
    megacmd

    # other
    tlrc
    libnotify
    dwt1-shell-color-scripts
  ];

  home.sessionVariables = {
    # fontpreview settings
    FONTPREVIEW_SIZE = "650x700";
    FONTPREVIEW_PREVIEW_TEXT = builtins.concatStringsSep ''\n'' [
      "SPHINX OF BLACK QUARTZ,"
      ''JUDGE MY VOW.\n''

      "Sphinx of Black Quartz,"
      ''Judge My Vow.\n''

      "sphinx of black quartz,"
      ''judge my vow.\n''

      "1234567890"
      ''!@$\%(){}[];:\'\"''
    ];
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    package = pkgs.unstable.fzf;

    defaultOptions = [
      "--height=60%"
      "--border"
      "--layout=reverse"
      "--cycle"
      "--no-scrollbar"
      "--no-bold"

      "--bind 'alt-k:up'"
      "--bind 'alt-j:down'"
      "--bind 'ctrl-y:execute-silent(printf {} | cut -f 2- | wl-copy --trim-newline)'"
    ];
  };

  programs.aria2 = {
    enable = true;
    settings = {
      file-allocation = "none";
      seed-time = 0;
    };
  };

  # Misc cli tools
  programs = {
    bat.enable = true;

    eza = {
      enable = true;
      icons = "auto";
      git = true;
      extraOptions = [
        "--group-directories-first"
        "--all"
        "--across"
      ];
    };

    zoxide = {
      enable = true;
      package = pkgs.unstable.zoxide;
    };
  };
}
