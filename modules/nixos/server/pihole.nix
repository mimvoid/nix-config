{ config, lib, ... }:
let
  auriga-domains =
    [ ]
    ++ lib.optionals config.services.karakeep.enable [ "karakeep.auri.dedyn.io" ]
    ++ lib.optionals config.services.nextcloud.enable [ config.services.nextcloud.hostName ]
    ++ lib.optionals config.services.immich.enable [ "immich.auri.dedyn.io" ];
in
{
  services.pihole-ftl = {
    enable = true;
    openFirewallDNS = true;
    settings.dns = {
      upstreams = [
        "1.1.1.1"
        "9.9.9.9"
      ];
      hosts = [ "10.0.0.27 ${builtins.concatStringsSep " " auriga-domains}" ];
    };
  };
}
