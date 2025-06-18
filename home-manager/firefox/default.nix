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
    nativeMessagingHosts = [
      firefoxpwa
      pywalfox-native
    ];
  };
}
