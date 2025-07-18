{ pkgs, ... }:

{
  # Restricting this to a user doesn't seem to work
  environment.systemPackages = with pkgs.xfce; [
    xfce4-docklike-plugin
    xfce4-pulseaudio-plugin
  ];

  # X11
  services.xserver = {
    enable = true;
    excludePackages = [ pkgs.xterm ];

    # Keyboard layouts
    xkb = {
      layout = "us";
      variant = ",intl";
    };
  };

  # XFCE
  services.xserver.desktopManager.xfce.enable = true;
  programs.xfconf.enable = true;

  environment.xfce.excludePackages =
    with pkgs; [
      gnome-themes-extra
      adwaita-icon-theme
      hicolor-icon-theme
      tango-icon-theme
    ]
    ++ (with pkgs.xfce; [
      xfwm4-themes
      xfce4-taskmanager
      xfce4-screenshooter
      xfce4-terminal
      xfce4-icon-theme
      ristretto
      mousepad
      parole
    ]);
}
