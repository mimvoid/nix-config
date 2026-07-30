{ inputs, lib, ... }:

{
  imports = builtins.attrValues {
    hardware = ./hardware-configuration.nix;
    hardware-extra = ./extra.nix;
    inherit (inputs.self.nixosModules)
      boot
      console
      core
      greetd
      hyprland
      intel
      nixConfig
      power
      printing
      packagers
      thunar
      xdgPortal
      zinnia
      zsh
      ;
  };

  networking.hostName = "sirru";

  # VGA compatible controller and audio device for IOMMU
  boot.kernelParams = lib.mkAfter [ "vfio-pci.ids=8086:9a78,8086:a0c8" ];
}
