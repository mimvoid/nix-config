{ inputs, ... }:

{
  imports = builtins.attrValues {
    hardware = ./hardware-configuration.nix;
    capella = ./capella.nix;
    inherit (inputs.self.nixosModules)
      boot
      console
      homeManager
      nixConfig
      zsh
      ;
  };

  networking.hostName = "auriga";

  networking.networkmanager.enable = true;
  networking.firewall.enable = true;

  environment.sessionVariables = {
    TERM = "xterm";
  };

  services.openssh = {
    enable = true;
    openFirewall = true;
    ports = [ 1776 ];
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = [ "capella" ];
    };
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  system.stateVersion = "26.05";
}
