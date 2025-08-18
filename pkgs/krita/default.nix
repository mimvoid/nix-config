{ pkgs, ... }:

let
  inherit (pkgs) callPackage;
in
{
  reference-tabs-docker = callPackage ./reference-tabs-docker { };
  composition-helper = callPackage ./composition-helper { };
  timer-watch = callPackage ./timer-watch { };
  shortcut-composer = callPackage ./shortcut-composer { };
}
