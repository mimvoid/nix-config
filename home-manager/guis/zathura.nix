{ pkgs, ... }:
let
  font-name = pkgs.theme.fonts.monospace.name;
  font-size = builtins.toString pkgs.theme.fonts.terminal-size;
in
{
  programs.zathura = {
    enable = true;
    options = {
      font = "${font-name} normal ${font-size}";
      guioptions = "sv";
      recolor = true;
      recolor-keephue = true;
      adjust-open = "width";

      statusbar-home-tilde = true;
      window-title-home-tilde = true;
      show-hidden = true;
      show-signature-information = true;

      scroll-step = 60;
      double-click-follow = true;
      selection-notification = false;
    };
  };
}
