{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # zsh
    zsh-autopair
    zsh-nix-shell
    zsh-vi-mode

    # media
    imagemagick
    exiftool
    fontpreview

    # disk & files
    trashy
    megacmd

    # other
    disfetch
    tlrc
    libnotify
    dwt1-shell-color-scripts
  ];

  programs.zsh = {
    enable = true;
    dotDir = "zsh";
    syntaxHighlighting.enable = true;
    
    history = {
      path = "$HOME/zsh/.zsh_history";
      ignoreDups = true;
      ignoreAllDups = true;
      ignorePatterns = [ "ls" "eza" "yazi" "yy" ];
    };

    historySubstringSearch.enable = true;
    
    shellAliases = {
      ".." = "cd ..";
      "-" = "cd -";

      nhos = "nh os switch";
      nhh = "nh home switch";
      nixdev = "nix develop --command zsh";
      
      blueon = "bluetooth on";
      btui = "bluetuith --no-help-display";

      lg = "lazygit";
      ncp = "neocities push --prune";

      # use a better syntax highlighting theme for batman
      man = "BAT_THEME=\"Dracula\" batman";
      arttime = "arttime --nolearn --style 1 --pa  --pb  --pl 20";
    };

    # make zsh-help work with -h flag
    shellGlobalAliases."-h" = "--help";

    initExtra = # bash
    ''
      # fontpreview settings
      export FONTPREVIEW_SIZE=650x700
      export FONTPREVIEW_PREVIEW_TEXT="SPHINX OF BLACK QUARTZ,\nJUDGE MY VOW.\n\nSphinx of Black Quartz,\nJudge My Vow.\n\nsphinx of black quartz,\njudge my vow.\n\n1234567890\n!@$\%(){}[];:\'\""

      # history substring search integration with vi mode
      bindkey -M vicmd 'k' history-substring-search-up
      bindkey -M vicmd 'j' history-substring-search-up

      # zsh-vi-mode customizations
      export ZVM_CURSOR_STYLE_ENABLED=false
      export ZVM_VI_HIGHLIGHT_FOREGROUND=yellow
      export ZVM_VI_HIGHLIGHT_BACKGROUND=black
    '';
    
    completionInit = " autoload -U compinit && compinit";
    plugins = [
      {
        name = "zsh-autopair";
        file = "share/zsh/zsh-autopair/autopair.zsh";
        src = pkgs.zsh-autopair;
      }
      {
        name = "zsh-nix-shell";
        file = "share/zsh-nix-shell/nix-shell.plugin.zsh";
        src = pkgs.zsh-nix-shell;
      }
      {
        name = "zsh-vi-mode";
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
        src = pkgs.zsh-vi-mode;
      }
      {
        name = "zsh-help";
        src = pkgs.fetchFromGitHub {
          owner = "Freed-Wu";
          repo = "zsh-help";
          rev = "66103d6682e0ffe83576208dd5e45e560cdb76f8";
          hash = "sha256-RiJK8A1dXq1O3m9t56/PHaP4T5Fyn5HumKPwJdYshX4=";
        };
      }
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
    bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [ batman ];
    };
    eza.enable = true;
    zoxide = {
      enable = true;
      package = pkgs.unstable.zoxide;
    };
  };
}
