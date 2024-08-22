{ config, ... }:

{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "foot -e";

        dpi-aware = true;
        width = 33;
        lines = 16;
        layer = "overlay";
        prompt = "'> '";
        icon-theme = config.gtk.iconTheme.name;
        exit-on-keyboard-focus-loss = false;

        horizontal-pad = 28;
        vertical-pad = 18;
        inner-pad = 16;

        fields = "filename,name";
      };
      border.radius = 8;
    };
  };
}
