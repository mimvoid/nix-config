{ pkgs, ... }:
let
  super-productivity = pkgs.callPackage ../../../packages/appimages/super-productivity.nix {};
in
{
  home.packages = [
    super-productivity
  ];

  xdg.configFile = {
    "superProductivity/styles.css".source = ./styles.css;
  };
}
