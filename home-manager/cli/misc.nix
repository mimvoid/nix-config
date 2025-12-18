{ pkgs, ... }:

{
  home.packages = builtins.attrValues {
    inherit (pkgs)
      gnumake

      # media
      imagemagick
      exiftool
      mediainfo
      nsxiv

      # other
      megacmd
      tlrc
      libnotify
      dwt1-shell-color-scripts
      ;
    inherit (pkgs.voids) mdopen;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    package = pkgs.unstable.fzf;

    defaultOptions = [
      "--height=60%"
      "--layout=reverse"
      "--cycle"
      "--no-scrollbar"
      "--no-bold"
      "--color=16"

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

  programs.navi = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.eza = {
    enable = true;
    icons = "auto";
    git = true;
    extraOptions = [
      "--group-directories-first"
      "--all"
      "--across"
    ];
  };

  programs.zoxide = {
    enable = true;
    package = pkgs.unstable.zoxide;
  };
}
