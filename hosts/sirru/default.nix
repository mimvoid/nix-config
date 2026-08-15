{ inputs, config, ... }:

{
  imports = builtins.attrValues {
    hardware = ./hardware-configuration.nix;
    inherit (inputs.self.nixosModules)
      boot
      console
      core
      desktop
      gamemode
      greetd
      hyprland
      intel
      nixConfig
      power
      printing
      sops
      thunar
      virt
      xdgPortal
      zinnia
      zsh
      ;
  };

  networking.hostName = "sirru";

  services.libinput.enable = true; # Touchpad support.
  programs.nix-ld.enable = true; # Enable binaries.

  # Wireguard client
  networking.wg-quick.interfaces.auriga = {
    address = [ "172.16.0.2/24" ];
    privateKeyFile = config.sops.secrets."wireguard/laptop_key".path;
    peers = [
      {
        publicKey = "80EyevBLy23Vmnn77lwVFkHyb4pcmV7Y0px6LL4uTVc=";
        allowedIPs = [
          "0.0.0.0/0"
          "::/0"
        ];
        endpoint = "10.0.0.27:56017"; # TODO: set up DDNS
      }
    ];
  };
  sops.secrets."wireguard/laptop_key" = { };
}
