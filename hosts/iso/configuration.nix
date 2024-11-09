{ modulesPath, ... }:

{
  imports = [ "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix" ];

  nixpkgs.hostPlatform = "x86_64-linux";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Disable wpa_supplicant for networkmanager
  networking = {
    wireless.enable = false;
    networkmanager.enable = true;
  };

  console.font = "ter-d28b";
}
