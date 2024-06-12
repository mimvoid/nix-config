{ pkgs, ... }:
let
  background = ../wallpapers/gracile_jellyfish.jpg;
  theme = {
    name = "Catppuccin-Mocha-Standard-Blue-Dark";
    package = (pkgs.catppuccin-gtk.override {
      accents = ["blue"];
      size = "standard";
      variant = "mocha";
    });
  };
  cursorTheme = {
    name = "BreezeX-RosePineDawn-Linux";
    package = pkgs.rose-pine-cursor;
    size = 24;
  };
  iconTheme = {
    name = "Adwaita";
    package = pkgs.gnome-themes-extra;
  };
in
{
  services.xserver.displayManager.lightdm = {
    enable = true;
    inherit background;
    greeter.enable = true;
    greeters.gtk = {
      enable = true;
      inherit theme cursorTheme iconTheme;
      indicators = [
        #"~host"
        "~spacer"
        "~clock"
        "~spacer"
        "~session"
        #"~language"
        #"~a11y"
        "~power"
      ];
      clock-format = "%A %b %d / %H:%M";
      extraConfig = '' #conf
        font-name = SauceCodePro Nerd Font
        xft-antialias = true
        xft-dpi = 144
        panel-position = top
        show-clock = true
        hide-user-image = true
        user-background = false
      '';
    };
  };
}
