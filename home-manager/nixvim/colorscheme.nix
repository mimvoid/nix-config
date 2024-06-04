{
  programs.nixvim.colorschemes.rose-pine = {
    enable = true;
    settings = {
      before_highlight = "function(group, highlight, palette) end";
      dark_variant = "moon";
      dim_inactive_windows = true;
      enable = {
        legacy_highlights = false;
        migrations = true;
        terminal = false;
      };
    extend_background_behind_borders = true;
    groups = {
      border = "muted";
      link = "iris";
      panel = "surface";
    };
    highlight_groups = { };
    styles = {
      bold = false;
      italic = true;
      transparency = true;
    };
    variant = "auto";
  };
}
