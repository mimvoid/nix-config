{ pkgs, ... }:

{
  users.users.capella = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    shell = pkgs.zsh;
  };

  home-manager.users.capella = {
    imports = [
      ../../home-manager/cli/shells
      ../../home-manager/cli/git.nix
      ../../home-manager/cli/pagers.nix
      ../../home-manager/cli/neovim.nix
    ];

    home.stateVersion = "23.11";
  };
}
