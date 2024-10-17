{ config, ... }:
let
  font-name = config.stylix.fonts.monospace.name;
  font-size = builtins.toString config.stylix.fonts.sizes.terminal;
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
