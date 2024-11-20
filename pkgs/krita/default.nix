{ pkgs, ... }:

with pkgs;
{
  reference-tabs-docker = callPackage ./reference-tabs-docker { };
  composition-helper = callPackage ./composition-helper { };
  timer-watch = callPackage ./timer-watch { };
}
