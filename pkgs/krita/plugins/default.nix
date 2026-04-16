{ pkgs }:
let
  inherit (pkgs) callPackage;
in
{
  composition-helper = callPackage ./composition-helper { };
  reference-tabs-docker = callPackage ./reference-tabs-docker { };
  shortcut-composer = callPackage ./shortcut-composer { };
  timer-watch = callPackage ./timer-watch { };
}
