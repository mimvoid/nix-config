{ inputs, ... }:

{
  imports = builtins.attrValues {
    hardware = ./hardware-configuration.nix;
    capella = ./capella.nix;
    inherit (inputs.self.nixosModules)
      boot
      console
      core
      homeManager
      nixConfig
      zsh
      ;
    inherit (inputs.self.nixosModules.server)
      acme
      ddns
      karakeep
      nginx
      nextcloud
      pihole
      wireguard
      ;
  };

  networking.hostName = "auriga";
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
}
