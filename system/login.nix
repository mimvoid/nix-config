{ pkgs, ... }:
let
  tgreet = pkgs.greetd.tuigreet;
  hyprland = "${pkgs.hyprland}/share/wayland-sessions";
  xfce = "${pkgs.xfce.xfce4-session}/share/xsessions";
in
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = builtins.concatStringsSep " " [
          "${tgreet}/bin/tuigreet"
          "--time --time-format '%A %b %d / %H:%M'"
          "--asterisks"
          "--remember --remember-session"
          "--sessions ${hyprland}"
          "--xsessions ${xfce}"
        ];
        user = "greeter";
      };
    };
  };

  # source: https://www.reddit.com/r/NixOS/comments/u0cdpi/tuigreet_with_xmonad_how/
  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal";
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };
}
