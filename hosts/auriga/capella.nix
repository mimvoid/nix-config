{ pkgs, inputs, ... }:

{
  imports = [ inputs.self.nixosModules.sops ];

  users.users.capella = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    shell = pkgs.zsh;
  };
  sops.age.keyFile = "/home/capella/.config/sops/age/keys.txt";

  home-manager.users.capella = {
    imports = [
      ../../home-manager/cli/shells
      ../../home-manager/cli/git.nix
      ../../home-manager/cli/pagers.nix
      ../../home-manager/cli/neovim.nix
    ];

    xdg.enable = true;
    home.stateVersion = "23.11";
  };
}
