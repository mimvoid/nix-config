{ config, ... }:

{
  programs.navi = {
    enable = true;
    enableZshIntegration = true;
  };

  xdg = {
    configFile."navi/config.yaml".source = ./config.yaml;
    dataFile."navi/cheats" = config.voids.lib.symlink "terminal/navi/cheats";
  };
}
