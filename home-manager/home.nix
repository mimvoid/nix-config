{
  home = {
    username = "zinnia";
    homeDirectory = "/home/zinnia";
    stateVersion = "23.11";

    preferXdgDirectories = true;
  };

  programs.home-manager.enable = true;
  xdg.enable = true;

  imports = [
    ./wayland
    ./terminal
    ./guis
    ./firefox
    ./krita
    ./theming

    ./ime.nix
    ./links.nix
    # ./tts.nix
    ./neovim.nix
    ./ags.nix
  ];
}
