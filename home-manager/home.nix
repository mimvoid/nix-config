{ ... }:

{
  home = {
    username = "zinnia";
    homeDirectory = "/home/zinnia";
    stateVersion = "23.11";
  };
    
  programs.home-manager.enable = true;

  imports = [
    ./theming.nix
    ./desktop.nix
    ./symlinks.nix
    ./terminal/default.nix
    ./nixvim/default.nix
    ./hyprland/default.nix
    ./guis/default.nix
    ./ags/ags.nix
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
