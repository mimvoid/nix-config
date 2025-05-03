{ pkgs, config, ... }:

{
  # Used to start an X11 session, and is faster than startx
  services.xserver.displayManager.sx.enable = true;

  # Let greetd unlock gnome keyring
  security.pam.services = {
    login.enableGnomeKeyring = true;
    greetd.enableGnomeKeyring = true;
  };

  services.greetd = {
    enable = true;
    settings.default_session = {
      command =
        let
          hyprland = "${pkgs.hyprland}/share/wayland-sessions";
          xfce = "${pkgs.xfce.xfce4-session}/share/xsessions";
          sx = "${config.services.xserver.displayManager.sx.package}/bin/sx";

          theme = builtins.concatStringsSep ";" [
            "border=blue"
            "container=black"
            "text=white"
            "time=yellow"
            "prompt=magenta"
            "input=gray"
            "action=blue"
            "button=yellow"
          ];
        in
        builtins.concatStringsSep " " [
          "${pkgs.greetd.tuigreet}/bin/tuigreet"
          "--greeting 'Welcome back!'"
          "--time --time-format '%a, %b %d %Y - %H:%M'"
          "--asterisks"
          "--window-padding 2 --container-padding 2"
          "--remember --remember-session"
          "--sessions ${hyprland}"
          "--xsessions ${xfce} --xsession-wrapper '${sx} /usr/bin/env'"
          "--theme '${theme}'"
        ];

      user = "greeter";
    };
  };

  # source: https://www.reddit.com/r/NixOS/comments/u0cdpi/tuigreet_with_xmonad_how
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
