{ config, ... }:

{
  programs.nixvim = {
    colorschemes.base16 = {
      setUpBar = true; # Stylix takes care of enabling and the base16 colors
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

    # Swap fg and bg highlights for telescope
    # Make rainbow delimiters match colorscheme
    highlightOverride = let
      c = config.lib.stylix.colors.withHashtag;
    in {
      TelescopePreviewTitle = { bg = c.base00; fg = c.green; };
      TelescopePromptTitle = { bg = c.base00; fg = c.red; };
      TelescopePromptPrefix.fg = c.red;

      RainbowDelimiterRed.fg = c.red;
      RainbowDelimiterYellow.fg = c.yellow;
      RainbowDelimiterBlue.fg = c.blue;
      RainbowDelimiterOrange.fg = c.yellow;
      RainbowDelimiterGreen.fg = c.green;
      RainbowDelimiterViolet.fg = c.magenta;
      RainbowDelimiterCyan.fg = c.cyan;
    };
  };
}
