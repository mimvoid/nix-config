{
  networking.firewall = {
    allowedUDPPorts = [ 53 ];
    allowedTCPPorts = [ 53 ];
  };

  services.blocky = {
    enable = true;
    settings = {
      upstreams.groups.default = [
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
      blocking = {
        denylists.ads = [
          "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/multi.txt"
        ];
        clientGroupsBlock.default = [ "ads" ];
      };
      customDNS.mapping."auri.dedyn.io" = "100.101.35.114";
      caching = {
        minTime = "5m";
        maxTime = "30m";
        prefetching = true;
      };
    };
  };
}
