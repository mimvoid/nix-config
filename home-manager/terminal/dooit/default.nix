{ flakePath, config, pkgs, ... }:

{
  imports = [ ./themes.nix ];
  home.packages = with pkgs.mods; [ dooit ];

  xdg.configFile =
    let
      here = "${flakePath}/home-manager/terminal/dooit";

      symlink = src: {
        source = config.lib.file.mkOutOfStoreSymlink "${here}/${src}";
      };
    in
    {
      "dooit/config.py" = symlink "config.py";
      "dooit/settings/ui.py" = symlink "settings/ui.py";
      "dooit/settings/formats.py" = symlink "settings/formats.py";
      "dooit/settings/vars.py" = symlink "settings/vars.py";
    };
}
