{ pkgs, ... }:

{
  imports = [ ./zsh.nix ];

  users.users.zinnia = {
    isNormalUser = true;
    description = "zinnia";

    extraGroups = [
      "wheel"
      "networkmanager"
      "podman"
    ];

    shell = pkgs.zsh;
  };

  nix.settings.trusted-users = pkgs.lib.mkAfter [ "zinnia" ];
}
