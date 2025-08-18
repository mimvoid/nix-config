{ inputs, pkgs, ... }:

{
  # cachix set up in configuration.nix

  home.packages = [
    inputs.aagl.packages.${pkgs.system}.honkers-railway-launcher
  ];
}
