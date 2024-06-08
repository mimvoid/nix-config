{
  programs.nixvim = {
    colorschemes.base16 = {
      enable = true;
      setUpBar = true;
      colorscheme = "rose-pine-moon";
    };

    # Enable telescope borders, disable plugins that aren't installed
    extraConfigLuaPre = ''
      require('base16-colorscheme').with_config({
        telescope = true,
        telescope_borders = true,
        cmp = true,
        lsp_semantic = true,
        indentblankline = false,
        notify = false,
        ts_rainbow = false,
        illuminate = false,
        dapui = false,
      })
    '';

    # Swap foreground and background highlights
    # Make the prompt prefix red
    highlightOverride = {
      TelescopePreviewTitle = { bg = "#232136"; fg = "#3e8fb0"; };
      TelescopePromptTitle = { bg = "#232136"; fg = "#eb6f92"; };
      TelescopePromptPrefix = { fg = "#eb6f92"; };
    };
  };
}
