{ inputs, pkgs, ... }:
let
  inherit (pkgs.unstable) firefoxpwa;
in
{
  home.packages = [
    firefoxpwa
    inputs.zen-browser.packages.${pkgs.system}.default
  ];

  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    nativeMessagingHosts = [ firefoxpwa ];
  };
}
