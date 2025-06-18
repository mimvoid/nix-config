{ flakePath, pkgs, ... }:

{
  home.packages = with pkgs; [
    gnumake
    unstable.zoxide

    # media
    imagemagick
    exiftool
    mediainfo
    voids.fontpreview
    nsxiv

    # other
    megacmd
    tlrc
    libnotify
    dwt1-shell-color-scripts
    voids.mdopen
  ];

  home.sessionVariables = {
    NH_FLAKE = flakePath;

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

    # fontpreview settings
    FONTPREVIEW_SIZE = "650x700";
    FONTPREVIEW_PREVIEW_TEXT = pkgs.lib.strings.concatLines [
      "SPHINX OF BLACK QUARTZ,"
      "JUDGE MY VOW."
      "" # extra /n line break
      "Sphinx of Black Quartz,"
      "Judge My Vow."
      ""
      "sphinx of black quartz,"
      "judge my vow."
      ""
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

  programs = {
    bat.enable = true;
    lesspipe.enable = true;

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
  };
}
