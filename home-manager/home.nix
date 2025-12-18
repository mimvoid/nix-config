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
    ./cli
    ./gui
    ./firefox
    ./krita
    ./links
    ./theme
    ./wayland

    ./ags.nix
    ./ime.nix
    # ./tts.nix
  ];
}
