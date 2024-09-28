{ pkgs, ... }:

{
  home.packages = [ (pkgs.callPackage ../../../packages/super-productivity.nix {}) ];

  xdg.configFile = {
    "superProductivity/styles.css".source = ./styles.css;
  };
}
