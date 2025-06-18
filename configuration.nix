{ inputs, pkgs, ... }:

{
  imports = [ ./system ];

  # General system configurations
  nix = {
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
        "https://ezkea.cachix.org" # for aagl
      ];
      trusted-public-keys = [
        "mimvoid.cachix.org-1:c1LQSKRAc7IiFA8GuaTDzD4fqUIG49Cftb2aJwqvtzY="
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

  # Minimum system packages, most are in home manager
  environment.systemPackages = with pkgs; [
    nh
    git
  ];

  services.flatpak.enable = true;

  # Desktop environments
  # & window managers
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
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

  # Networks & connections
  networking = {
    hostName = "sirru";
    networkmanager.enable = true;
  };

  # CUPS
  services.printing = {
    enable = true;
    drivers = with pkgs; [ epson-escpr ];
  };

  programs.system-config-printer.enable = true;

  #---------------#
  # Miscellaneous #
  #---------------#

  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  system.stateVersion = "23.11";
}
