{ inputs, ... }:

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
    dns = [ "10.0.0.27" ];
    privateKeyFile = "/etc/wireguard/laptop_key";
    peers = [
      {
        publicKey = "80EyevBLy23Vmnn77lwVFkHyb4pcmV7Y0px6LL4uTVc=";
        allowedIPs = [
          "0.0.0.0/0"
          "::/0"
        ];
        endpoint = "auri.dedyn.io:56017";
      }
    ];
  };
}
