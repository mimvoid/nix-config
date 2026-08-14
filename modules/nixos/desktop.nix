{
  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;

  hardware.graphics.enable = true; # hardware accelerated graphics drivers
  hardware.bluetooth.enable = true;
  hardware.opentabletdriver.enable = true; # drawing tablet support

  # Sound
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
}
