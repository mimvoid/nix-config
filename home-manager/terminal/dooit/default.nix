{ config, pkgs, ... }:

{
  imports = [ ./themes.nix ];
  home.packages = [ pkgs.mods.dooit ];

  xdg.configFile =
    let
      symlink = src: config.voids.lib.symlink "terminal/dooit/${src}";
    in
    {
      "dooit/config.py" = symlink "config.py";
      "dooit/settings/ui.py" = symlink "settings/ui.py";
      "dooit/settings/formats.py" = symlink "settings/formats.py";
      "dooit/settings/vars.py" = symlink "settings/vars.py";
    };
}
