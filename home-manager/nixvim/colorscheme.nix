{
  programs.nixvim = {
    colorschemes.base16 = {
      enable = true;
      setUpBar = true;
      colorscheme = "rose-pine-moon";
    };

    # Enable telescope borders
    extraConfigLuaPre = ''
      require('base16-colorscheme').with_config({
        telescope = true,
        telescope_borders = true,
        indentblankline = true,
        notify = false,
        ts_rainbow = false,
        cmp = true,
        illuminate = false,
        lsp_semantic = true,
        dapui = false,
      })
    '';

    highlightOverride = {
      TelescopePreviewTitle = { bg = "#232136"; fg = "#3e8fb0"; };
      TelescopePromptTitle = { bg = "#232136"; fg = "#eb6f92"; };
      TelescopePromptPrefix = { fg = "#eb5f92"; };
    };
  };
}
