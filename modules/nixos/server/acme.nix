{ config, ... }:

{
  security.acme = {
    acceptTerms = true;
    certs."auri.dedyn.io" = {
      domain = "auri.dedyn.io";
      extraDomainNames = [
        "karakeep.auri.dedyn.io"
        config.services.nextcloud.hostName
      ];
      reloadServices = [ "nginx" ];

      dnsProvider = "desec";
      dnsPropagationCheck = true;
      credentialFiles.DESEC_TOKEN_FILE = config.sops.secrets."desec/nginx_proxy".path;
    };
  };
  users.users.nginx.extraGroups = [ "acme" ];

  sops.secrets."desec/nginx_proxy" = { };
}
