{ inputs, lib, ... }:

{
  imports = builtins.attrValues {
    hardware = ./hardware-configuration.nix;
    inherit (inputs.self.nixosModules)
      boot
      console
      core
      games
      greetd
      hyprland
      intel
      nixConfig
      power
      printing
      packagers
      thunar
      virt
      xdgPortal
      zinnia
      zsh
      ;
  };

  networking.hostName = "sirru";
}
