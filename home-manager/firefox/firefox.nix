{ pkgs, ... }:

{
  home.packages = [ pkgs.unstable.firefoxpwa ];
  
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    nativeMessagingHosts = [ pkgs.unstable.firefoxpwa ];
  };
}
