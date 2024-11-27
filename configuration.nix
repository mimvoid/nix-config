{ inputs, pkgs, ... }:

{
  imports = [ ./system ];

  # General system configurations
  nix = {
    # https://github.com/NixOS/nix/issues/10815
    package = pkgs.nixVersions.nix_2_20;

    nixPath = [
      "nixpkgs=${inputs.nixpkgs}"
      "nixpkgs-unstable=${inputs.nixpkgs-unstable}"
    ];

    settings = {
      allow-dirty = true;
      warn-dirty = false; # No dirty Git tree reminders on rebuild
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;

      # Binary caches from cachix
      substituters = [
        "https://mimvoid.cachix.org"
        "https://nix-community.cachix.org"
        "https://ezkea.cachix.org" # for aagl
      ];
      trusted-public-keys = [
        "mimvoid.cachix.org-1:c1LQSKRAc7IiFA8GuaTDzD4fqUIG49Cftb2aJwqvtzY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="
      ];
      trusted-users = [ "root" "zinnia" ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs"
      "--commit-lock-file"
    ];
  };

  # Minimum system packages, most are in home manager
  environment.systemPackages = with pkgs; [
    nh
    git

    # Restricting this to a user doesn't seem to work
    xfce.xfce4-docklike-plugin
    xfce.xfce4-pulseaudio-plugin
  ];

  services.flatpak.enable = true;

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

  programs.xwayland.enable = true;

  # Desktop environments
  # & window managers
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-xapp
      xdg-desktop-portal-gtk
    ];
  };

  # XFCE
  services.xserver.desktopManager.xfce = {
    enable = true;
    enableXfwm = true;
    enableScreensaver = true;
    noDesktop = false;
  };

  programs.xfconf.enable = true;

  environment.xfce.excludePackages = with pkgs; [
    gnome-themes-extra
    adwaita-icon-theme
    hicolor-icon-theme
    tango-icon-theme
    xfce.xfwm4-themes
    xfce.xfce4-taskmanager
    xfce.xfce4-screenshooter
    xfce.xfce4-terminal
    xfce.xfce4-icon-theme
    xfce.mousepad
    xfce.parole
    xfce.ristretto
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

    extraGroups = [
      "wheel"
      "networkmanager"
    ];

    shell = pkgs.zsh;
  };

  environment.pathsToLink = [ "/share/zsh" ];
  programs.zsh = {
    enable = true;
    enableBashCompletion = true;
  };

  programs.gamemode = {
    enable = true;
    settings.custom = {
      start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
      end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
    };
  };

  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;

  # Touchpad support
  services.libinput.enable = true;

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-compute-runtime
      vpl-gpu-rt
    ];
  };

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

  services.tlp = {
    enable = true;
    settings = {
      USB_EXCLUDE_BTUSB = 1;
    };
  };
  services.auto-cpufreq.enable = true;

  # Networks & connections
  networking = {
    hostName = "sirru";
    networkmanager.enable = true;
  };

  hardware.bluetooth.enable = true;

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

  programs.system-config-printer.enable = true;

  # Thunar additions
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-media-tags-plugin
    ];
  };

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
