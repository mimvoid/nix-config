{ pkgs, inputs, ... }:

{
  home.packages = [
    inputs.nvim.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  # Make default editor
  home.sessionVariables.EDITOR = "nvim";
}
