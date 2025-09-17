{ pkgs, ... }:
let
  historyIgnore = [
    "ls" "la" "ll" "eza"
    ".." "..." "z" "-"
    "yazi" "yy"
    "nhos" "nhh"
    "exit"
    "lg"
  ];

  aliases = builtins.readFile ./aliases.sh;
  profileExtra = builtins.readFile ./profile.sh;
in
{
  programs.bash = {
    enable = true;
    shellOptions = [ ];

    inherit historyIgnore profileExtra;

    initExtra = # sh
      ''
        shopt -s \
          histappend \
          extglob \
          globstar \
          cdspell \
          autocd \
          checkwinsize \
          checkjobs

        ${aliases}
      '';
  };

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    syntaxHighlighting.enable = true;

    history = {
      path = "$XDG_STATE_HOME/zsh/.zsh_history";
      ignoreDups = true;
      ignoreAllDups = true;
      findNoDups = true;
      saveNoDups = true;
      expireDuplicatesFirst = true;
      ignorePatterns = historyIgnore;
    };
    historySubstringSearch.enable = true;

    inherit profileExtra;

    initContent =
      pkgs.lib.mkAfter # sh
        ''
          setopt autocd
          setopt correct # offer to correct mistyped commands

          # expand aliases with TAB
          zstyle ':completion:*' completer _expand_alias _complete _ignored

          # history substring search integration with vi mode
          bindkey -M vicmd 'k' history-substring-search-up
          bindkey -M vicmd 'j' history-substring-search-up

          ${aliases}

          # make zsh-help work with -h flag
          alias -g -- -h=--help
        '';

    # zsh plugin configuration
    plugins = [
      {
        name = "zsh-autopair";
        src = pkgs.zsh-autopair;
        file = "share/zsh/zsh-autopair/autopair.zsh";
      }
      {
        name = "zsh-nix-shell";
        src = pkgs.zsh-nix-shell;
        file = "share/zsh-nix-shell/nix-shell.plugin.zsh";
      }
      {
        name = "zsh-vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
      {
        name = "zsh-help";
        src = pkgs.voids.zsh-help;
      }
    ];

    sessionVariables = {
      # zsh-vi-mode customizations
      ZVM_CURSOR_STYLE_ENABLED = false;
      ZVM_VI_HIGHLIGHT_FOREGROUND = "yellow";
      ZVM_VI_HIGHLIGHT_BACKGROUND = "black";
    };
  };
}
