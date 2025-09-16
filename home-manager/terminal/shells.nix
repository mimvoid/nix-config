{ pkgs, ... }:

{
  home.shellAliases = {
    "-" = "cd -";
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

  programs =
    let
      historyIgnore = [
        "ls" "la" "ll" "eza"
        ".." "..." "z" "-"
        "yazi" "yy"
        "nhos" "nhh"
        "exit"
        "lg"
      ];

      profileExtra = #sh
        ''
          export ICEAUTHORITY="$XDG_CACHE_HOME"/ICEauthority
          export FFMPEG_DATADIR="$XDG_CONFIG_HOME"/ffmpeg
          export WINEPREFIX="$XDG_DATA_HOME/wineprefixes/default"
          export _Z_DATA="$XDG_DATA_HOME/z"

          export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
          export MACHINE_STORAGE_PATH="$XDG_DATA_HOME"/docker-machine

          export CARGO_HOME="$XDG_DATA_HOME"/cargo
          export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
          export NUGET_PACKAGES="$XDG_CACHE_HOME/NuGetPackages"

          export GOPATH="$XDG_DATA_HOME"/go
          export GOBIN="$GOPATH/bin"
          export GOMODCACHE="$XDG_CACHE_HOME"/go/mod

          export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
          export _JAVA_AWT_WM_NONREPARENTING=1

          export PYTHON_HISTORY=$XDG_STATE_HOME/python_history
          export PYTHONPYCACHEPREFIX=$XDG_CACHE_HOME/python
          export PYTHONUSERBASE=$XDG_DATA_HOME/python

          export MAVEN_OPTS=-Dmaven.repo.local="$XDG_DATA_HOME"/maven/repository
          export MAVEN_ARGS="--settings $XDG_CONFIG_HOME/maven/settings.xml"
          export RUFF_CACHE_DIR=$XDG_CACHE_HOME/ruff

          export XCOMPOSEFILE="$XDG_CONFIG_HOME"/x11/xcompose
          export XCOMPOSECACHE="$XDG_CACHE_HOME"/x11/xcompose
          export XINITRC="$XDG_CONFIG_HOME"/x11/xinitrc
          export XSERVERRC="$XDG_CONFIG_HOME"/x11/xserverrc
        '';
    in
    {
      bash = {
        enable = true;
        shellOptions = [
          "histappend"
          "checkwinsize"
          "extglob"
          "globstar"
          "checkjobs"
          "cdspell"
          "autocd"
        ];
        inherit historyIgnore profileExtra;
      };

      zsh = {
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
          pkgs.lib.mkAfter
            # sh
            ''
              setopt autocd
              setopt correct # offer to correct mistyped commands

              # expand aliases with TAB
              zstyle ':completion:*' completer _expand_alias _complete _ignored

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
    };
}
