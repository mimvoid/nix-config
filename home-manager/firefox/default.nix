{ config, pkgs, ... }:
let
  inherit (config.voids) flakeDir;
  firefox-profile = "30dphuug.default";
in
{
  programs.firefox = {
    enable = true;
    package = pkgs.unstable.firefox;
    configPath = ".mozilla/firefox";
  };

  # Firefox userChrome & userContent
  home.file.".mozilla/firefox/${firefox-profile}/chrome".source =
    config.lib.file.mkOutOfStoreSymlink "${flakeDir}/home/firefox/panefox";
}
