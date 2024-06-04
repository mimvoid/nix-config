{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        dpi-aware = true;
        #terminal = "foot";
        width = 72;
        lines = 36;
        layer = "overlay";
        prompt = "'> '";
        icon-theme = "Papirus";
        exit-on-keyboard-focus-loss = false;

        horizontal-pad = 32;
        vertical-pad = 18;
        inner-pad = 16;
        border-radius = 4;

        fields = "filename,name";
      };
    };
  };
}
