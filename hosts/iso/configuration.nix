{ pkgs, modulesPath, ... }:

{
  imports = [ "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix" ];

  nixpkgs.hostPlatform = "x86_64-linux";

  # Disable wpa_supplicant for networkmanager
  networking = {
    wireless.enable = false;
    networkmanager.enable = true;
  };
}
