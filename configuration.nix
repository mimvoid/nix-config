{ pkgs, lib, allowed-unfree-packages, ... }:

{
  imports = [
    ./hosts/h2/hardware-configuration.nix
    ./system/login.nix
    ./system/boot.nix
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
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) allowed-unfree-packages;
  services.flatpak.enable = true;

  # Minimum system packages, most are in home manager
  environment.systemPackages = with pkgs; [
    nh
    git
    wget
    curl

    # Restricting this to a user doesn't seem to work
    xfce.xfce4-docklike-plugin
  ];

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "SourceCodePro" ]; })
  ];

  console = {
    font = "ter-d28b";
    packages = [ pkgs.terminus_font ];
    useXkbConfig = true;
  };

  # X11
  services.xserver = {
    enable = true;
    xkb.layout = "us"; # Keymap in X11
  };

  programs.xwayland.enable = true;


  # Desktop environments 
  # & window managers
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-xapp
    ];
  };

  # XFCE
  services.xserver.displayManager.startx.enable = true;

  services.xserver.desktopManager.xfce = {
    enable = true;
    enableXfwm = true;
    enableScreensaver = true;
    noDesktop = false;
  };

  programs.xfconf.enable = true;

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
    extraGroups = [ "wheel" "networkmanager" ];
    packages = with pkgs; [
      neovim
      appimage-run 
    ];
    shell = pkgs.zsh;
  };

  programs = {
    zsh.enable = true;
    firefox.enable = true;
    steam.enable = true;
  };

  security.polkit.enable = true;
  
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.zinnia.enableGnomeKeyring = true;

  # Touchpad support
  services.libinput.enable = true;

  # Sound
  services.pipewire = {
    enable = true;
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
  i18n.defaultLocale = "en_US.UTF-8";

  system.stateVersion = "23.11";
}
