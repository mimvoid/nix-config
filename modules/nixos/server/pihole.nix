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
        # CloudFlare
        "1.1.1.1"
        "1.0.0.1"
        "2606:4700:4700::1111"
        "2606:4700:4700::1001"

        # Quad9
        "9.9.9.9"
        "149.112.112.112"
        "2620:fe::fe"
        "2620:fe::9"
      ];

      hosts = [ "100.101.35.114 ${builtins.concatStringsSep " " auriga-domains}" ];
    };

    lists = [
      {
        enabled = true;
        description = "hagezi Normal blocklist";
        url = "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/multi.txt";
        type = "block";
      }
    ];
  };

  services.pihole-web = {
    enable = true;
    ports = [ "8443s" ];
  };
}
