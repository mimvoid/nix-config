{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [ (inputs.nvim.packages.${system}.default) ];

  home.sessionVariables.EDITOR = "nvim";
}
