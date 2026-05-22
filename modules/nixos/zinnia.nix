{ pkgs, config, lib, ... }:

{
  imports = [ ./zsh.nix ];

  users.users.zinnia = {
    isNormalUser = true;
    description = "zinnia";

    extraGroups = [
      "wheel"
      "networkmanager"
    ]
    ++ lib.optionals config.virtualisation.podman.enable [ "podman" ];

    shell = pkgs.zsh;
  };

  nix.settings.trusted-users = lib.mkAfter [ "zinnia" ];
}
