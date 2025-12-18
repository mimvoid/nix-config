{ pkgs, ... }:
let
  font-name = pkgs.theme.fonts.monospace.name;
  font-size = pkgs.theme.fonts.terminal-size;
in
{
  programs.zathura = {
    enable = true;
    options = {
      default-bg =
        let
          bg = pkgs.palettes.moonfall-eve.rgbSplit.nadir // {
            a = 0.75;
          };
          bgStr = pkgs.palettes.lib.strings.joinRgba bg;
        in
        pkgs.lib.mkForce bgStr;

      font = "${font-name} normal ${toString font-size}";
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
