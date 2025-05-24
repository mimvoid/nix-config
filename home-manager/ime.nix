{ pkgs, ... }:

{
  # Pinyin for Simplified Chinese
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        fcitx5-gtk
        fcitx5-rime
        mods.catppuccin-fcitx5
      ];
    };
  };
}
