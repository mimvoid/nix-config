{ pkgs, ... }:

# Like the home-manager wlsunset module, but with an added duration argument

{
  systemd.user.services.wlsunset = {
    Unit = {
      Description = "Day/night gamma adjustments for Wayland compositors.";
      PartOf = [ "graphical-session.target" ];
    };

    Service.ExecStart = "${pkgs.wlsunset}/bin/wlsunset -T 5000 -S 7:30 -t 2500 -s 20:00 -d 1800";

    Install.WantedBy = [ "hyprland-session.target" ];
  };
}
