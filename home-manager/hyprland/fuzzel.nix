{ ... }:

{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        dpi-aware = true;
        #font = "SauceCodePro Nerd Font:size=9";
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
      #colors = {
        #background = "24273a" + "ee"; # base
        #text = "cad3f5" + "ff"; # text
        #match = "f0bdef" + "ff";
        #selection = "494d64" + "dd"; #surface1
        #selection-match = "f5bde6" + "ff"; # pink
        #selection-text = "f4dbd6" + "ff"; # rosewater
        #border = "ee99a0" + "ff"; # maroon
      #};
    };
  };
}
