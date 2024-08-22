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
    ./home-links.nix
    ./terminal/default.nix
    ./nixvim/default.nix
    ./hyprland/default.nix
    ./xfconf/default.nix
    ./guis/default.nix
    ./firefox/firefox.nix
    ./ags/ags.nix
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
}
