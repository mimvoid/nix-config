{ config, ... }:

{
  security.acme = {
    acceptTerms = true;
    certs."auri.dedyn.io" = {
      domain = "*.auri.dedyn.io";
      group = "nginx";
      reloadServices = [ "nginx" ];

      dnsProvider = "desec";
      dnsResolver = "ns1.desec.io.:53,ns2.desec.org.:53";
      credentialFiles.DESEC_TOKEN_FILE = config.sops.secrets."desec/nginx_proxy".path;
    };
  };

  # See: https://talk.desec.io/t/no-subdomain-because-the-domain-and-the-zone-are-identical/1044
  systemd.services."acme-order-renew-auri.dedyn.io".environment.LEGO_DISABLE_CNAME_SUPPORT = "true";

  sops.secrets."desec/nginx_proxy" = { };
}
