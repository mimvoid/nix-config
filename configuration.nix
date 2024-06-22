{ pkgs, ... }:

{
  imports = [
    ./hosts/h1/hardware-configuration.nix
    ./system/lightdm.nix
    ./system/grub.nix
    ./system/virt.nix
  ];

  # General system configurations
  nix = {
    package = pkgs.nixFlakes;
    settings = {
      allow-dirty = true;
      warn-dirty = false; # No dirty Git tree reminders on rebuild
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
  };
  system.autoUpgrade.enable = true;

  # Package sources
  nixpkgs.config.allowUnfree = true;
  services.flatpak.enable = true;

  # Minimum system packages, most are in home manager
  environment.systemPackages = with pkgs; [
    git
    nh
    wget
    curl
  ];

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "SourceCodePro" ]; })
  ];

  # X11
  services.xserver = {
    enable = true;

    # Configure keymap in X11
    xkb.layout = "us";
    xkb.variant = "";
  };

  programs.xwayland.enable = true;


  # Desktop environments 
  # & window managers
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-kde
    ];
  };

  # KDE Plasma 6
  #services.desktopManager.plasma6 = {
  #  enable = true;
  #  enableQt5Integration = true;
  #};

  #environment.plasma6.excludePackages = with pkgs.kdePackages; [
  #  okular
  #  kate
  #  khelpcenter
  #  dolphin-plugins
  #];

  # XFCE
  services.xserver.desktopManager.xfce = {
    enable = true;
    enableXfwm = true;
    enableScreensaver = true;
    noDesktop = false;
  };

  environment.xfce.excludePackages = with pkgs; [
    gnome.gnome-themes-extra
    gnome.adwaita-icon-theme
    hicolor-icon-theme
    tango-icon-theme
    xfce.xfce4-terminal
    xfce.xfce4-icon-theme
    xfce.mousepad
    xfce.parole
  ];
  
  # Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  #-----------------#
  # Apps & Services #
  #-----------------#

  users.users.zinnia = {
    isNormalUser = true;
    description = "zinnia";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      neovim
      appimage-run
      xfce.xfce4-docklike-plugin
    ];
    shell = pkgs.zsh;
  };

  programs = {
    zsh.enable = true;
    firefox.enable = true;
  };

  security.polkit.enable = true;
  
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.zinnia.enableGnomeKeyring = true;

  programs.xfconf.enable = true;

  # Touchpad support
  services.libinput.enable = true;

  # Pipewire
  sound.enable = true;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Power management
  services.upower = {
    enable = true;
    usePercentageForPolicy = true;
    percentageLow = 40;
    percentageCritical = 20;

    percentageAction = 5;
    criticalPowerAction = "HybridSleep";
  };
  services.power-profiles-daemon.enable = true;

  # Networks & connections
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # CUPS
  services.printing = {
    enable = true;
    package = pkgs.cups;
    drivers = with pkgs; [
      epson-escpr
      epson-escpr2
      epsonscan2
    ];
    startWhenNeeded = true;
  };

  services.system-config-printer.enable = true;
  programs.system-config-printer.enable = true;

  # Thunar additions 
  services.gvfs = {
    enable = true;
    package = pkgs.gvfs;
  };

  services.tumbler.enable = true;

  #---------------#
  # Miscellaneous #
  #---------------#

  time.timeZone = "America/New_York";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  system.stateVersion = "23.11";
}
