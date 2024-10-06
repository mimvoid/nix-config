{ pkgs, lib, ... }:
let
  markview = pkgs.vimUtils.buildVimPlugin {
    name = "markview.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "OXY2DEV";
      repo = "markview.nvim";
      rev = "v24.0.0";
      hash = "sha256-Bkwhg4RstOSRx+Jmjq5n2xjEkvyZ4Mx85lWn0YqRHxY=";
    };
  };
in
{
  programs.nixvim = {
    extraPlugins = lib.mkAfter [
      markview
    ];

    extraConfigLua = lib.mkAfter # lua
    ''
      require("markview").setup({
        checkboxes = require("markview.presets").checkboxes.legacy,
        headings = require("markview.presets").headings.marker,
        horizontal_rules = require("markview.presets").horizontal_rules.thin
      })
    '';
  };

  # programs.nixvim.plugins.markdown-preview = {
  #   enable = true;
  #   settings = {
  #     auto_close = true;
  #     auto_start = false;
  #     browser = "firefox";
  #   };
  # };
}
