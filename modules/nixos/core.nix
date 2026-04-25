{
  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;

  hardware = {
    graphics.enable = true; # hardware accelerated graphics drivers
    bluetooth.enable = true;
    opentabletdriver.enable = true; # drawing tablet support
  };
  services.libinput.enable = true; # touchpad support

  # Sound
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  networking.networkmanager.enable = true;

  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  system.stateVersion = "23.11";
}
