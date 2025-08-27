{ config, ... }:
let
  symlink = src: config.voids.lib.symlink "krita/scripts/${src}";
in
{
  xdg.dataFile = {
    "krita/pykrita/mimvoid_scripts.desktop" = symlink "mimvoid_scripts.desktop";
    "krita/pykrita/mimvoid_scripts" = symlink "mimvoid_scripts";
  };
}
