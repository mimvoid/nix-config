{ pkgs, ... }:
let
  firefoxpwa = pkgs.unstable.firefoxpwa;
in
{
  home.packages = [ firefoxpwa ];

  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    nativeMessagingHosts = [ firefoxpwa ];
  };
}
