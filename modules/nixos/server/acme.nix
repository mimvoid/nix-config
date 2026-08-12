{ config, ... }:

{
  security.acme = {
    acceptTerms = true;
    certs."auriga.cafe" = {
      domain = "auriga.cafe";
      extraDomainNames = [
        "karakeep.auriga.cafe"
        config.services.nextcloud.hostName
      ];
      reloadServices = [ "nginx" ];

      dnsProvider = "desec";
      dnsPropagationCheck = true;
      credentialFiles.DESEC_TOKEN_FILE = config.sops.secrets."acme/auriga_cafe/desec_token".path;
    };
  };
  users.users.nginx.extraGroups = [ "acme" ];

  sops.secrets."acme/auriga_cafe/desec_token" = { };
}
