{ pkgs, ... }:

{
  # Pinyin for Simplified Chinese
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      addons = [
        pkgs.fcitx5-gtk
        pkgs.fcitx5-rime
        pkgs.mods.catppuccin-fcitx5
      ];
    };
  };
}
