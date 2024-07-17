{ pkgs, ... }:
let
  tgreet = pkgs.greetd.tuigreet;
  hyprland = "${pkgs.hyprland}/share/wayland-sessions";
  xfce = "${pkgs.xfce.xfce4-session}/share/xsessions";
in
{
  # Required to start an X11 session
  services.xserver.displayManager.startx.enable = true;
  
  # Let greetd unlock gnome keyring
  security.pam.services = {
    login.enableGnomeKeyring = true;
    greetd.enableGnomeKeyring = true;
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = builtins.concatStringsSep " " [
          "${tgreet}/bin/tuigreet"
          "--greeting 'Welcome back!'"
          "--time --time-format '%a, %b %d %Y - %H:%M'"
          "--asterisks"
          "--window-padding 2"
          "--container-padding 2"
          "--remember --remember-session"
          "--sessions ${hyprland}"
          "--xsessions ${xfce}"
          "--theme 'border=blue;container=black;text=white;time=yellow;prompt=magenta;input=gray;action=blue;button=yellow'"
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
