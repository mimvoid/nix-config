{ pkgs, ... }:
let
  inherit (pkgs.unstable) firefoxpwa;
  inherit (pkgs) pywalfox-native;
in
{
  home.packages = [
    firefoxpwa
    pywalfox-native
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
