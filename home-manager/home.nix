{ pkgs, ... }:

{
  home = {
    username = "zinnia";
    homeDirectory = "/home/zinnia";
    stateVersion = "23.11";
  };

  programs.home-manager.enable = true;

  imports = [
    ./theming.nix
    ./links.nix
    #./tts.nix
    ./krita/default.nix
    ./terminal/default.nix
    ./nixvim/default.nix
    ./hyprland/default.nix
    ./xfconf/default.nix
    ./guis/default.nix
    ./firefox/firefox.nix
    ./ags/default.nix
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Pinyin for Simplified Chinese
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      fcitx5-chinese-addons
      unstable.catppuccin-fcitx5
    ];
  };
  # GTK & QT settings
  gtk = {
    gtk3.extraConfig.gtk-im-module = "fcitx";
    gtk4.extraConfig.gtk-im-module = "fcitx";
  };
}
