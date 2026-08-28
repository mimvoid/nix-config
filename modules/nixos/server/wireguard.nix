{
  pkgs,
  lib,
  config,
  ...
}:

{
  imports = [ ../sops.nix ];

  networking.nat = {
    enable = true;
    enableIPv6 = true;
    externalInterface = "eno1";
    internalInterfaces = [ "auriga" ];
  };

  networking.firewall.allowedUDPPorts = [ 56017 ];

  networking.wg-quick.interfaces.auriga =
    let
      iptables = lib.getExe' pkgs.iptables "iptables";
      ipv4Prefix = "172.16.0";
      commands = flag: ''
        ${iptables} ${flag} FORWARD -i auriga -j ACCEPT
        ${iptables} -t nat ${flag} POSTROUTING -s ${ipv4Prefix}.1/24 -o eno1 -j MASQUERADE
      '';
    in
    {
      address = [ "${ipv4Prefix}.1/24" ];
      listenPort = 56017;
      postUp = commands "-A";
      preDown = commands "-D";
      privateKeyFile = config.sops.secrets."wireguard/server_key".path;
      peers = [
        {
          # Laptop
          publicKey = "74Bx2M/9GRhIxnid5TeEXWCFKnQw1V67c3nFwqOhdQw=";
          allowedIPs = [ "${ipv4Prefix}.2/32" ];
        }
        {
          # Phone
          publicKey = "LprM3dO0zCsqtiQ29Qhhyde3nGDnQihnmRhLeA0CkVs=";
          allowedIPs = [ "${ipv4Prefix}.3/32" ];
        }
      ];
    };

  sops.secrets."wireguard/server_key" = { };
}
