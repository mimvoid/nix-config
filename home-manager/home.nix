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
    ./links.nix
    #./tts.nix
    ./krita
    ./neovim
    ./terminal
    ./hyprland
    ./xfconf
    ./guis
    ./firefox
    ./ags
  ];


  # Pinyin for Simplified Chinese
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      fcitx5-chinese-addons
      unstable.catppuccin-fcitx5
    ];
  };
}
