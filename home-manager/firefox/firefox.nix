{ pkgs, ... }:

{
  home.packages = [ pkgs.firefoxpwa ];
  
  programs.firefox = {
    enable = true;
    package = pkgs.unstable.firefox-beta;
  };
}
