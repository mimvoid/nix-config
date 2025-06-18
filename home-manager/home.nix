{ pkgs, ... }:

{
  home = {
    username = "zinnia";
    homeDirectory = "/home/zinnia";
    stateVersion = "23.11";

    enableNixpkgsReleaseCheck = false;
    preferXdgDirectories = true;
  };

  programs.home-manager.enable = true;

  imports = [
    ./theming.nix
    ./ime.nix
    ./hellwal
    ./matugen
    ./links.nix
    ./tts.nix
    ./krita
    ./neovim.nix
    ./terminal
    ./hypr
    ./xfconf
    ./guis
    ./firefox
    ./ags
  ];

  home.packages = with pkgs; [
    unstable.ollama
    unstable.alpaca
    (fontforge-gtk.override { withPython = false; })
  ];
}
