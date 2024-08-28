{ config, ... }:

{
  programs.nixvim = {
    colorschemes.base16 = {
      # Stylix takes care of enabling and the base16 colors
      setUpBar = true;
    };

    # Enable telescope borders, disable plugins that aren't installed
    extraConfigLuaPre = ''
      require('base16-colorscheme').with_config({
        telescope = true,
        telescope_borders = true,
        dapui = true,
        cmp = true,
        lsp_semantic = true,

        illuminate = false,
        indentblankline = false,
        mini_completion = false,
        notify = false,
        ts_rainbow = false,
      })
    '';

    # Swap foreground and background highlights for telescope
    # Make the prompt prefix red
    highlightOverride = let
      col = config.stylix.base16Scheme;
    in {
      TelescopePreviewTitle = { bg = "#${col.base00}"; fg = "#${col.base0B}"; };
      TelescopePromptTitle = { bg = "#${col.base00}"; fg = "#${col.base08}"; };
      TelescopePromptPrefix = { fg = "#${col.base08}"; };

      RainbowDelimiterRed.fg = "#${col.base08}";
      RainbowDelimiterYellow.fg = "#${col.base0A}";
      RainbowDelimiterBlue.fg = "#${col.base0D}";
      RainbowDelimiterOrange.fg = "#${col.base0A}";
      RainbowDelimiterGreen.fg = "#${col.base0B}";
      RainbowDelimiterViolet.fg = "#${col.base0E}";
      RainbowDelimiterCyan.fg = "#${col.base0C}";
    };
  };
}
