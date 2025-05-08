{ inputs, pkgs, ... }:
let
  inherit (pkgs.unstable) firefoxpwa;
  inherit (pkgs) pywalfox-native;
in
{
  home.packages = [
    firefoxpwa
    pywalfox-native
    inputs.zen-browser.packages.${pkgs.system}.default
  ];

  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    nativeMessagingHosts = [
      firefoxpwa
      pywalfox-native
    ];
  };
}
