{ pkgs, ... }:
# Colors and fonts are managed by Stylix
{
  programs.foot = {
    enable = true;
    package = pkgs.unstable.foot;
    settings = {
      main.pad = "14x0";
      scrollback = {
        lines = 2048;
        indicator-position = "fixed";
        indicator-format = "percentage";
      };
      cursor = {
        style = "block";
        unfocused-style = "hollow";
      };
      mouse = {
        hide-when-typing = "yes";
      };
    };
  };
}
