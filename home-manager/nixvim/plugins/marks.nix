{ pkgs, lib, ... }:
let
  nvim-project-marks = pkgs.vimUtils.buildVimPlugin {
    name = "nvim-project-marks";
    src = pkgs.fetchFromGitHub {
      owner = "BartSte";
      repo = "nvim-project-marks";
      rev = "0.2.0";
      hash = "sha256-/LC/URb4sEURa7S9Ht20k9eTbJ3tZCvkHRwcxlBfra0=";
    };
  };
in
{
  programs.nixvim = {
    plugins.marks.enable = true;

    extraPlugins = lib.mkAfter [ nvim-project-marks ];

    extraConfigLua =
      lib.mkAfter # lua
        ''
          require("projectmarks").setup({})
        '';
  };
}
