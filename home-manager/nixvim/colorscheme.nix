{ config, ... }:

{
  programs.nixvim = {
    globals.borderStyle = "rounded";

    colorschemes.base16 = {
      setUpBar = true; # Stylix takes care of enabling and the base16 colors
      settings.telescope_borders = true;
    };

    highlightOverride = with config.lib.stylix.colors.withHashtag; {
      # Swap fg and bg highlights for telescope
      TelescopePreviewTitle = {
        bg = base00;
        fg = green;
      };
      TelescopePromptTitle = {
        bg = base00;
        fg = red;
      };
      TelescopePromptPrefix.fg = red;

      # Make rainbow delimiters match colorscheme
      RainbowDelimiterRed.fg = red;
      RainbowDelimiterYellow.fg = yellow;
      RainbowDelimiterBlue.fg = blue;
      RainbowDelimiterOrange.fg = yellow;
      RainbowDelimiterGreen.fg = green;
      RainbowDelimiterViolet.fg = magenta;
      RainbowDelimiterCyan.fg = cyan;
    };
  };
}
