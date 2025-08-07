{ ... }:

{
  home = {
    username = "zinnia";
    homeDirectory = "/home/zinnia";
    stateVersion = "23.11";

    preferXdgDirectories = true;
  };

  programs.home-manager.enable = true;

  imports = [
    ./wayland
    ./terminal
    ./guis
    ./firefox
    ./theming

    ./ime.nix
    ./links.nix
    ./tts.nix
    ./krita
    ./neovim.nix
    ./ags.nix
  ];
}
