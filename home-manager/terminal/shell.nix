{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # zsh
    zsh-z
    zsh-autopair
    zsh-nix-shell

    # media
    imagemagick
    exiftool
    fontpreview

    # other
    nix-tree
    disfetch
    tlrc
    megacmd
    libnotify
  ];

  programs.zsh = {
    enable = true;
    dotDir = "zsh";
    syntaxHighlighting.enable = true;
    
    history = {
      path = "$HOME/zsh/.zsh_history";
      ignoreDups = true;
      ignorePatterns = [ "ls" "eza" "yazi" "yy" ];
    };
    
    historySubstringSearch = {
      enable = true;
      searchUpKey = "$terminfo[kcuu1]";
      searchDownKey = "$terminfo[kcud1]";
    };
    
    shellAliases = {
      nhos = "nh os switch ~/NixOS";
      nhh = "nh home switch ~/NixOS";
      
      ncp = "neocities push --prune src";
    };

    # HACK: setting up arttime without packaging it
    initExtra = ''
      PATH=$PATH:~/.local/bin
      fpath+="$HOME/.local/share/zsh/functions"

      export FONTPREVIEW_SIZE=650x700
      export FONTPREVIEW_PREVIEW_TEXT="SPHINX OF BLACK QUARTZ,\nJUDGE MY VOW.\n\nSphinx of Black Quartz,\nJudge My Vow.\n\nsphinx of black quartz,\njudge my vow.\n\n1234567890\n!@$\%(){}[];:\'\""
    '';
    
    completionInit = " autoload -U compinit && compinit";
    plugins = [
      {
        name = "zsh-z";
        file = "share/zsh-z/zsh-z.plugin.zsh";
        src = pkgs.zsh-z;
      }
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

  programs = {
    bat.enable = true;
    eza.enable = true;
    man.enable = true;
    ripgrep.enable = true;
  };
}
