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

  cmp-r = pkgs.vimUtils.buildVimPlugin {
    name = "cmp-r";
    src = pkgs.fetchFromGitHub {
      owner = "R-nvim";
      repo = "cmp-r";
      rev = "18b88eeb7e47996623b9aa0a763677ac00a16221";
      hash = "sha256-3h+7q/x5xST50b9MdjR+9JULTwgn6kAyyrL5qhCtta0=";
    };
  };
in
{
  programs.nixvim = {
    extraPlugins = lib.mkAfter [
      r-nvim
      cmp-r
    ];

    extraConfigLua = # lua
    ''
      require("r").setup({
        hl_term = true,
        Rout_more_colors = true,
      })
    '';

    globals.rout_follow_colorscheme = true;

    plugins.cmp.settings.sources = lib.mkAfter [
      { name = "cmp_r"; }
    ];
  };
}
