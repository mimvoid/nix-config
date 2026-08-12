{ pkgs, ... }:
let
  port = 3000;
in
{
  services.karakeep = {
    enable = true;
    package = pkgs.unstable.karakeep; # The stable branch had an insecure pnpm
    extraEnvironment = {
      PORT = toString port;
      DISABLE_SIGNUPS = "true";
      DISABLE_NEW_RELEASE_CHECK = "true";
      LOG_LEVEL = "warning";
    };
  };

  services.nginx.virtualHosts."karakeep.auriga.cafe" = {
    useACMEHost = "auriga.cafe";
    forceSSL = true;
    locations."/".proxyPass = "http://127.0.0.1:${toString port}";
  };
}
