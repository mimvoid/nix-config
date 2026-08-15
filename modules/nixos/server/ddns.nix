{ config, ... }:

{
  imports = [ ../sops.nix ];

  services.ddns-updater = {
    enable = true;
    environment = {
      SERVER_ENABLED = "no"; # disable web server and UI
      CONFIG_FILEPATH = "/etc/ddns-updater/config.json";
      PERIOD = "5m";
    };
  };

  sops.secrets."desec/ddns" = { };
  sops.templates."ddns-updater.json".content = ''
    {
      "settings": [
        {
          "provider": "desec",
          "domain": "auri.dedyn.io",
          "token": "${config.sops.placeholder."desec/ddns"}"
        }
      ]
    }
  '';

  environment.etc."ddns-updater/config.json" = {
    source = config.sops.templates."ddns-updater.json".path;
    mode = "0644";
  };
}
