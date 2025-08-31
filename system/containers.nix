{ lib, ... }:

{
  # Enable common container config files in /etc/containers
  virtualisation.containers.enable = true;

  virtualisation.podman = {
    enable = true;
    dockerCompat = true; # Set `docker` alias
    autoPrune.enable = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  users.users.zinnia.extraGroups = lib.mkAfter [
    "podman"
  ];
}
