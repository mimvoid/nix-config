{ pkgs, ... }:

{
  home.shellAliases = {
    ".." = "cd ..";
    "..." = "cd ../..";

    # nix aliases
    nhos = "nh os switch";
    nhh = "nh home switch";

    # command shorthands
    lg = "lazygit";

    # config aliases
    arttime = "arttime --nolearn --style 1 --pa  --pb  --pl 20";
  };

  programs.bash.enable = true;

  programs.zsh = {
    enable = true;
    dotDir = "zsh";
    syntaxHighlighting.enable = true;

    history = {
      path = "$HOME/zsh/.zsh_history";
      extended = true;
      ignoreDups = true;
      ignoreAllDups = true;
      ignorePatterns = [
        "ls"
        "la"
        "ll"
        "eza"
        ".."
        "..."
        "z"
        "-"
        "yazi"
        "yy"
        "nhos"
        "nhh"
        "exit"
        "lg"
      ];
    };
    historySubstringSearch.enable = true;
    autocd = true;

    shellAliases."-" = "cd -";

    initContent = # sh
      ''
        # history substring search integration with vi mode
        bindkey -M vicmd 'k' history-substring-search-up
        bindkey -M vicmd 'j' history-substring-search-up

        # nix develop with zsh shell
        function nixdev() {
          nix develop ''${1} --command zsh
        }

        # enter a nix shell with package from unstable branch
        function nixpkg-unstable() {
          nix shell nixpkgs/nixos-unstable#''${1}
        }

        function kitsd() {
          kitty --detach --session ''${1} && exit
        }
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

    # make zsh-help work with -h flag
    shellGlobalAliases."-h" = "--help";
  };
}
