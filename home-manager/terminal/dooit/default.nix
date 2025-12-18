{ pkgs, ... }:

{
  imports = [ ./themes.nix ];
  home.packages = [ pkgs.mods.dooit ];
}
