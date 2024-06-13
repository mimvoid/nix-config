{ pkgs, ... }:

{
  home.packages = [ pkgs.firefoxpwa ];
  
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-beta;
  };
}
