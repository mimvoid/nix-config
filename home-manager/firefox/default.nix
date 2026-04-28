{ config, pkgs, ... }:
let
  inherit (config.voids.lib) flakePath;
  firefox-profile = "30dphuug.default";
in
{
  programs.firefox = {
    enable = true;
    package = pkgs.unstable.firefox;
  };

  # Firefox userChrome & userContent
  home.file.".mozilla/firefox/${firefox-profile}/chrome".source =
    config.lib.file.mkOutOfStoreSymlink "${flakePath}/home/firefox/panefox";
}
