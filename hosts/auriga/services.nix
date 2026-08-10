{
  services.karakeep = {
    enable = true;
    package = pkgs.unstable.karakeep; # The stable branch had an insecure pnpm
    extraEnvironment = {
      PORT = toString ports.karakeep;
      DISABLE_SIGNUPS = "true";
      DISABLE_NEW_RELEASE_CHECK = "true";
      LOG_LEVEL = "warning";
    };
  };

  networking.firewall.allowedTCPPorts = [
    3000 # Karakeep
  ];
}
