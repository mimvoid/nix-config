{ pkgs, ... }:

{
  # Allows wlsunset to launch with a terminal command
  home.packages = [ pkgs.wlsunset ];

  services.wlsunset = {
    enable = true;
    systemdTarget = "hyprland-session.target";
    sunrise = "7:30";
    sunset = "20:00";
    temperature = {
      day = 5000;
      night = 2500;
    };
  };
}
