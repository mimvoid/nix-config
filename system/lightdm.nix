{ pkgs, ... }:
let
  cursorTheme = {
    name = "BreezeX-RosePineDawn-Linux";
    package = pkgs.rose-pine-cursor;
    size = 24;
  };
  iconTheme = {
    name = "Papirus Dark";
    package = (pkgs.catppuccin-papirus-folders.override {
      flavor = "macchiato";
      accent = "blue";
    });
  };
in
{
  services.xserver.displayManager.lightdm = {
    enable = true;
    background = ../wallpapers/gracile_jellyfish.jpg;
    greeter.enable = true;
    greeters = {
      enable = true;
      gtk = {
        enable = true;
        indicators = [
          "~host"
          "~spacer"
          "~clock"
          "~spacer"
          "~session"
          #"~language"
          "~a11y"
          "~power"
        ];
        inherit cursorTheme iconTheme;
        clock-format = "%H:%M";
      };
    };
  };
}
