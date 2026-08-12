{ config, inputs, ... }:

{
  imports = [ inputs.self.nixosModules.sops ];

  services.nextcloud = {
    enable = true;
    hostName = "nextcloud.auriga.cafe";
    https = true;
    database.createLocally = true;
    configureRedis = true;
    config = {
      adminuser = "gye";
      dbtype = "mysql";
      adminpassFile = config.sops.secrets."nextcloud/admin_pass".path;
    };
    phpOptions."opcache.interned_strings_buffer" = "16";
    settings = {
      maintenance_window_start = 1;
      default_phone_region = "US";
      trusted_proxies = [ "127.0.0.1" ];
      log_type = "systemd";
      serverid = 0;
      enabledPreviewProviders = [
        "OC\\Preview\\BMP"
        "OC\\Preview\\GIF"
        "OC\\Preview\\JPEG"
        "OC\\Preview\\Krita"
        "OC\\Preview\\MarkDown"
        "OC\\Preview\\OpenDocument"
        "OC\\Preview\\PNG"
        "OC\\Preview\\TXT"
        "OC\\Preview\\WebP"
        "OC\\Preview\\XBitmap"
        "OC\\Preview\\HEIC"
      ];
    };
  };

  services.nginx.virtualHosts."nextcloud.auriga.cafe" = {
    useACMEHost = "auriga.cafe";
    forceSSL = true;
  };

  users.users.nextcloud.extraGroups = [ "user" ];
  sops.secrets."nextcloud/admin_pass" = { };
}
