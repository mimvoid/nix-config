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
    ./hellwal
    ./matugen
    ./links.nix
    ./tts.nix
    ./krita
    ./neovim
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

  # Pinyin for Simplified Chinese
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      fcitx5-rime
      catppuccin-fcitx5
    ];
  };
}
