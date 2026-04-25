{ inputs, ... }:

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
}
