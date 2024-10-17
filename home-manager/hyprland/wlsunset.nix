{ pkgs, lib, ... }:

{
  # Allows wlsunset to launch with a terminal command
  home.packages = [ pkgs.wlsunset ];

  # Set up custom args (duration)
  systemd.user.services.wlsunset = {
    Unit = {
      Description = "Day/night gamma adjustments for Wayland compositors.";
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = let
        args = lib.cli.toGNUCommandLineShell { } {
          # Daytime
          T = 5000;
          S = "7:30";
          # Nighttime
          t = 2500;
          s = "20:00";
          # Duration
          d = 1800;
        };
      in "${pkgs.wlsunset}/bin/wlsunset ${args}";
    };

    Install = { WantedBy = [ "hyprland-session.target" ]; };
  };

  # services.wlsunset = {
  #   enable = true;
  #   systemdTarget = "hyprland-session.target";
  #   sunrise = "7:30";
  #   sunset = "20:00";
  #   temperature = {
  #     day = 5000;
  #     night = 2500;
  #   };
  # };
}
