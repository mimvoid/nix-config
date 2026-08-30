{
  # Rootless docker
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true; # Point DOCKER_HOST to the rootless Docker instance
    };
  };
}
