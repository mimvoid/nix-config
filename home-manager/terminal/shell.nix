{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # zsh
    zsh-z
    zsh-autopair
    zsh-nix-shell

    # other
    nh
    disfetch
    tlrc
    exiftool
    megacmd
    fontpreview
  ];

  programs.bash = {
    enable = true;
    enableCompletion = true;
    historyControl = [ "erasedups" "ignoredups" ];
    historyIgnore = [ "ls" "cd" "exit" ];
  };

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
      
      yy = "ya";
    };

    initExtra = ''
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

  programs = {
    bat.enable = true;
    eza.enable = true;
    man.enable = true;
    ripgrep.enable = true;
  };
}
