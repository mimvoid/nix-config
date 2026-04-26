{ inputs, pkgs, ... }:

{
  # cachix set up in configuration.nix

  home.packages = [
    inputs.aagl.packages.${pkgs.stdenv.hostPlatform.system}.honkers-railway-launcher
  ];
}
