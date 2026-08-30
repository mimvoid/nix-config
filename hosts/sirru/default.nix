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
      tailscale
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
}
