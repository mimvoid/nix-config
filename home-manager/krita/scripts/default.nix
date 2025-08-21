{ flakePath, config, ... }:
let
  here = "${flakePath}/home-manager/krita/scripts";

  symlink = src: {
    source = config.lib.file.mkOutOfStoreSymlink "${here}/${src}";
  };
in
{
  xdg.dataFile = {
    "krita/pykrita/mimvoid_scripts.desktop" = symlink "mimvoid_scripts.desktop";
    "krita/pykrita/mimvoid_scripts" = symlink "mimvoid_scripts";
  };
}
