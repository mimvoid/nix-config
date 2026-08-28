{
  pkgs,
  lib,
  config,
  ...
}:
let
  listenPort = 56017;
  ipv4Prefix = "172.16.0";
  ipv6Prefix = "fd16:bf08:57cb";
  externalInterface = "eno1";
in
{
  imports = [ ../sops.nix ];

  networking.nat = {
    enable = true;
    enableIPv6 = true;
    inherit externalInterface;
    internalInterfaces = [ "wg0" ];
  };
  networking.firewall.allowedUDPPorts = [ listenPort ];

  networking.wg-quick.interfaces.wg0 =
    let
      iptables = lib.getExe' pkgs.iptables "iptables";
      ip6tables = lib.getExe' pkgs.iptables "ip6tables";

      # Allow traffic fowarded to or from interface wg0
      # Relay traffic through Wireguard's subnet to the internet
      commands = flag: ''
        ${iptables} ${flag} FORWARD -i wg0 -j ACCEPT
        ${iptables} -t nat ${flag} POSTROUTING -s ${ipv4Prefix}.0/24 -o ${externalInterface} -j MASQUERADE
        ${ip6tables} ${flag} FORWARD -i wg0 -j ACCEPT
        ${ip6tables} -t nat ${flag} POSTROUTING -s ${ipv6Prefix}::/64 -o ${externalInterface} -j MASQUERADE
      '';
    in
    {
      inherit listenPort;
      address = [
        "${ipv4Prefix}.1/24"
        "${ipv6Prefix}::1/64"
      ];

      postUp = commands "-A";
      preDown = commands "-D";
      privateKeyFile = config.sops.secrets."wireguard/server_key".path;

      peers = [
        {
          # Laptop
          publicKey = "74Bx2M/9GRhIxnid5TeEXWCFKnQw1V67c3nFwqOhdQw=";
          allowedIPs = [
            "${ipv4Prefix}.2/32"
            "${ipv6Prefix}::2/128"
          ];
        }
        {
          # Phone
          publicKey = "LprM3dO0zCsqtiQ29Qhhyde3nGDnQihnmRhLeA0CkVs=";
          allowedIPs = [
            "${ipv4Prefix}.3/32"
            "${ipv6Prefix}::3/128"
          ];
        }
      ];
    };

  sops.secrets."wireguard/server_key" = { };
}
