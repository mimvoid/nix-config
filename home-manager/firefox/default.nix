{ config, pkgs, ... }:
let
  inherit (config.voids.lib) symlink;
  firefox-profile = "30dphuug.default";
in
{
  programs.firefox = {
    enable = true;
    package = pkgs.unstable.firefox;
  };

  home.file = {
    # Firefox userChrome & userContent
    ".mozilla/firefox/${firefox-profile}/chrome" = symlink "firefox/panefox";
  };
}
