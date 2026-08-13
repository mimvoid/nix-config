{ pkgs, ... }:

{
  programs.zathura = {
    enable = true;
    options = {
      font =
        let
          font-name = pkgs.theme.fonts.monospace.name;
          font-size = pkgs.theme.fonts.terminal-size;
        in
        "${font-name} normal ${toString font-size}";

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
    }
    // pkgs.palettes.lib.attrsets.joinRgba (
      with pkgs.palettes.moonfall-eve.rgbSplit.base16;
      {
        default-bg = base00 // {
          a = 0.75;
        };
        default-fg = base01;
        statusbar-fg = base04;
        statusbar-bg = base02;
        inputbar-bg = base00;
        inputbar-fg = base07;
        notification-bg = base00;
        notification-fg = base07;
        notification-error-bg = base00;
        notification-error-fg = base08;
        notification-warning-bg = base00;
        notification-warning-fg = base08;
        highlight-color = base0A // {
          a = 0.5;
        };
        highlight-active-color = base0D // {
          a = 0.5;
        };
        completion-bg = base01;
        completion-fg = base0D;
        completion-highlight-fg = base07;
        completion-highlight-bg = base0D;
        recolor-lightcolor = base00;
        recolor-darkcolor = base06;
      }
    );
  };
}
