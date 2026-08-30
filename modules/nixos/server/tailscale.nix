{ config, ... }:

{
  imports = [
    ../tailscale.nix
    ../sops.nix
  ];

  services.tailscale.authKeyFile = config.sops.secrets."tailscale/auriga_key".path;

  # Let Pi-Hole listen to TailScale clients.
  # This is fine since the router does not open port 53, but it still feels bad.
  services.pihole-ftl.settings.dns.listeningMode = "ALL";

  sops.secrets."tailscale/auriga_key" = { };
}
