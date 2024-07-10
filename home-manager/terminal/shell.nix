{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # zsh
    zsh-z
    zsh-autopair
    zsh-syntax-highlighting

    # Nix integrations
    zsh-nix-shell
    nix-zsh-completions
    nh

    # misc
    eza
    disfetch
    tlrc
    exiftool
    megacmd
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
      ignorePatterns = [ "ls" "eza" "exit" "yazi" "yy" ];
    };
    
    historySubstringSearch = {
      enable = true;
      searchUpKey = "$terminfo[kcuu1]";
      searchDownKey = "$terminfo[kcud1]";
    };
    
    shellAliases = {
      nhos = "nh os switch ~/NixOS";
      nhh = "nh home switch ~/NixOS";
      
      ya = "yy";
    };
    
    completionInit = " autoload -U compinit && compinit";
    initExtra = ''
      source $HOME/zsh/plugins/zsh-autopair/share/zsh/zsh-autopair/autopair.zsh
      source $HOME/zsh/plugins/zsh-z/share/zsh-z/zsh-z.plugin.zsh
      source $HOME/zsh/plugins/zsh-z
      zstyle ':completion:*' menu select
      
      # Let Yazi change current directory
      function yy() {
	      local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	      yazi "$@" --cwd-file="$tmp"
	      if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		      cd -- "$cwd"
	      fi
	      rm -f -- "$tmp"
      }
    '';
    plugins = [
      { name = "zsh-z"; src = pkgs.zsh-z; }
      { name = "zsh-autopair"; src = pkgs.zsh-autopair; }
    ];
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs = {
    bat.enable = true;
    ripgrep.enable = true;
  };
}
