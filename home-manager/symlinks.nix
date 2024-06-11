{ config, ... }:

{
  xdg.configFile = {
    "ags" = {
      enable = true;
      source = config.lib.file.mkOutOfStoreSymlink ./ags;
    };
  };
}
