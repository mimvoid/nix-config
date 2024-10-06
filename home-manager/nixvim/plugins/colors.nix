{ pkgs, lib, ... }:

{
  # nvim-highlight-colors
  programs.nixvim = {
    extraPlugins = lib.mkAfter [
      pkgs.vimPlugins.nvim-highlight-colors
    ];

    extraConfigLua = lib.mkAfter # lua
    ''
      require("nvim-highlight-colors").setup({
        render = "background",

        enable_hex = true, -- like #ee99b0
        enable_short_hex = true, -- like #ccc

        enable_rgb = true, -- like rgb(225, 225, 255)
        enable_hsl = true, -- like hsl(150deg 30% 40%)

        enable_var_usage = true,
        enable_named_colors = false
      })
    '';

    plugins.cmp.settings.formatting.format = "require('nvim-highlight-colors').format";
  };
}
