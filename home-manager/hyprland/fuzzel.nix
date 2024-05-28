{ pkgs, ... }:

{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        dip-aware = true;
        font = "SauceCodePro Nerd Font:size=9";
        #terminal = "foot";
        width = 74;
        lines = 36;
        layer = "overlay";
        prompt = "> ";
        #icon-theme = "Rowaita-Pink-Dark";
        exit-on-keyboard-focus-loss = false;

        horizontal-pad = 32;
        vertical-pad = 18;
        inner-pad = 16;

        fields = "filename,name";
      };
      colors = {
        background = "24273a" + "ee"; # base
        text = "cad365" + "ff"; # text
        match = "f0bdef" + "ff";
        selection = "494d64" + "dd";
        selection-match = "f5bde6" + "ff";
        selection-text = "f4dbd6" + "ff";
        border = "ee99a0" + "ff"; 
      };
    };
  };
}
