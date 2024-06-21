{ pkgs, modulesPath, ... }:

{
  imports = [ "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix" ];

  nixpkgs.hostPlatform = "x86_64-linux";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [
    gptfdisk
    xterm
    git
    neovim
  ];

  fonts.packages = [ (pkgs.nerdfonts.override { fonts = ["SourceCodePro"]; }) ];
  
  # Disable wpa_supplicant for networkmanager
  networking = {
    wireless.enable = false;
    networkmanager.enable = true;
  };

  services.xserver = {
    enable = true;

    # Configure keymap in X11
    xkb.layout = "us";
    xkb.variant = "";
  };

  # Touchpad support
  services.libinput.enable = true;

  # XFCE
  services.xserver.desktopManager.xfce = {
    enable = true;
    enableXfwm = true;
    enableScreensaver = false;
    noDesktop = false;
  };

  environment.xfce.excludePackages = with pkgs; [
    gnome.gnome-themes-extra
    hicolor-icon-theme
    tango-icon-theme
    xfce.xfce4-terminal
    xfce.xfce4-icon-theme
    xfce.xfce4-screenshooter
    xfce.xfce4-taskmanager
    xfce.xfce4-notifyd
    xfce.xfce4-session
    xfce.mousepad
    xfce.parole
    xfce.ristretto
  ];
}
