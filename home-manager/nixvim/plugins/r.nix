{ pkgs, lib, ... }:
let
  # Add nvimcom and other R packages elsewhere with shells
  r-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "R.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "R-nvim";
      repo = "R.nvim";
      rev = "v0.1.0";
      hash = "sha256-TMcnmMkMsB0lNAAcVAC1751pnV44xz2BCMLGcMbs8Xs=";
    };
  };
in
{
  programs.nixvim = {
    extraPlugins = lib.mkAfter [ r-nvim ];

    extraConfigLua = # lua
      ''
        require("r").setup({
          hl_term = true,
          Rout_more_colors = true,
        })
      '';

    globals.rout_follow_colorscheme = true;
  };
}
