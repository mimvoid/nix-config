{ config, pkgs, ...}:

{
programs = {
  hypridle = {
    enable = true;

    settings = {

      general = {
        lock_cmd = "hyprlock";
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
      };

      listener = [
        # Idle warning
        {
          timeout = 540;
          on-timeout = "notify-send 'Hypridle' 'Are you there...?'";
          on-resume = "notify-send 'Hypridle' 'Welcome back!'";
        }
        # Screen locking
        {
          timeout = 600;
          on-timeout = "hyprlock";
          on-resume = "notify-send 'Hyprland' 'Welcome back!'";
        }
        # Sleep
        {
          timeout = 900;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };

#  hyprlock = {
#    enable = false; #Need to import settings with colors somehow...
#  };

#  fuzzel = {
#    enable = true;
#    settings = {
#      main = {
#
#      };
#      colors = {
#
#      };
#    };
#  };

};

services = {
  mako = {
    enable = true;

    anchor = "top-right";

    actions = true;
    defaultTimeout = 5000;
    ignoreTimeout = true;
    maxVisible = 5;

    icons = true;

    borderSize = 1;
    borderRadius = 4;
    padding = "8";

    font = "SauceCodePro Nerd Font Medium 9";

    backgroundColor = "#24273abb"; #transleucent base
    textColor = "#cad3f5"; #catppuccin text
    borderColor = "#f5bde6"; #pink?
    progressColor = "over #363a4f";
  };

  wlsunset = {
    enable = true;
    sunrise = "7:30";
    sunset = "20:00";
    temperature = {
      day = 5000;
      night = 2500;
    };
  };
};
}
