{ pkgs, ... }:

{
  home.packages = [ pkgs.dooit ];

  xdg.configFile = {
    "dooit/config.py".source = ./config.py;
    "dooit/extra.py".source = ./extra.py;
  };
}
