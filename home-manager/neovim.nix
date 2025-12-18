{ pkgs, inputs, ... }:

{
  home.packages = [
    inputs.nvim.packages.${pkgs.system}.default
  ];

  # Make default editor
  home.sessionVariables.EDITOR = "nvim";
}
