{ config, pkgs, ... }:

{
  imports = [ ./theme.nix ];
  home.packages = with pkgs.mods; [ dooit ];

  xdg.configFile =
    let
      here = "${config.home.sessionVariables.FLAKE}/home-manager/terminal/dooit";

      symlink = src: {
        source = config.lib.file.mkOutOfStoreSymlink "${here}/${src}";
      };
    in
    {
      "dooit/config.py" = symlink "config.py";
      "dooit/settings.py" = symlink "settings.py";
      "dooit/formats.py" = symlink "formats.py";
    };
}
