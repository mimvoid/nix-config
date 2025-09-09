{ config, ... }:
let
  inherit (config.voids.lib) symlink;
in
{
  xdg.configFile = {
    "ags" = symlink "ags";
    "wallpapers".source = ../wallpapers/wallpapers;
  };

  home.file =
    let
      firefox-profile = "30dphuug.default";
    in
    {
      # Firefox userChrome & userContent
      ".mozilla/firefox/${firefox-profile}/chrome" = symlink "firefox/panefox";
    };
}
