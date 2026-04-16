{ pkgs, ... }:
let
  plugins = import ./plugins { inherit pkgs; };
  resources = import ./resources { inherit pkgs; };
in
{
  inherit (plugins)
    composition-helper
    reference-tabs-docker
    shortcut-composer
    timer-watch
    ;

  inherit (resources)
    catppuccin-macchiato-maroon
    bundles
    ;
}
