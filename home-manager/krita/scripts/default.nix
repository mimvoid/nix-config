{ config, ... }:
let
  symlink = src: {
    source = config.lib.file.mkOutOfStoreSymlink src;
  };

  here = "${config.home.sessionVariables.FLAKE}/home-manager/krita/scripts";
in
{
  xdg.dataFile = {
    "krita/pykrita/mimvoid_scripts.desktop" = symlink "${here}/mimvoid_scripts.desktop";
    "krita/pykrita/mimvoid_scripts" = symlink "${here}/mimvoid_scripts";
  };
}
