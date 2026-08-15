{ config, ... }:

{
  services.immich = {
    enable = true;
    port = 2283;
    host = "127.0.0.1";
  };

  services.nginx.virtualHosts."immich.auri.dedyn.io" = {
    useACMEHost = "auri.dedyn.io";
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://127.0.0.1:${toString config.services.immich.port}";
      proxyWebsockets = true;
      extraConfig = ''
        client_max_body_size 50000M;
        proxy_read_timeout 600s;
        proxy_send_timeout 600s;
        send_timeout 600s;
      '';
    };
  };
}
