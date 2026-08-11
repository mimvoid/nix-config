{ pkgs, inputs, config, ... }:
let
  ports = {
    karakeep = 3000;
  };
in
{
  imports = [ inputs.self.nixosModules.sops ];

  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    appendHttpConfig = ''
      # Minimize information leaked to other domains
      add_header 'Referrer-Policy' 'origin-when-cross-origin';

      # Disable embedding as a frame
      add_header X-Frame-Options DENY;

      # Prevent injection of code in other mime types (XSS attacks)
      add_header X-Content-Type-Options nosniff;
    '';

    virtualHosts = {
      "karakeep.auriga.cafe" = {
        useACMEHost = "auriga.cafe";
        forceSSL = true;
        locations."/".proxyPass = "http://127.0.0.1:${toString ports.karakeep}";
      };
    };
  };

  # Applications

  services.karakeep = {
    enable = true;
    package = pkgs.unstable.karakeep; # The stable branch had an insecure pnpm
    extraEnvironment = {
      PORT = toString ports.karakeep;
      DISABLE_SIGNUPS = "true";
      DISABLE_NEW_RELEASE_CHECK = "true";
      LOG_LEVEL = "warning";
    };
  };

  # Security & DNS

  networking.firewall.allowedTCPPorts = [ 80 443 ];

  services.pihole-ftl = {
    enable = true;
    openFirewallDNS = true;
    settings.dns = {
      upstreams = [ "1.1.1.1" "9.9.9.9" ];
      hosts = [ "10.0.0.27 auriga.cafe karakeep.auriga.cafe" ];
    };
  };

  security.acme = {
    acceptTerms = true;
    certs."auriga.cafe" = {
      domain = "auriga.cafe";
      extraDomainNames = [ "karakeep.auriga.cafe" ];
      reloadServices = [ "nginx" ];

      dnsProvider = "desec";
      dnsPropagationCheck = true;
      credentialFiles.DESEC_TOKEN_FILE = config.sops.secrets."acme/auriga_cafe/desec_token".path;
    };
  };
  users.users.nginx.extraGroups = [ "acme" ];

  sops.age.keyFile = "/home/capella/.config/sops/age/keys.txt";
  sops.secrets."acme/auriga_cafe/desec_token" = { };
}
