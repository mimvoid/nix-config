{ pkgs, ... }:

{
  home.packages = with pkgs; [ unstable.inlyne ];

  xdg.configFile."inlyne/inlyne.toml".text = # toml
    ''
      theme = "Dark"
      scale = 1.5
      page-width = 1600

      # GitHub dark colors
      [dark-theme]
      text-color = 0xadbac7
      background-color = 0x22272e
      code-color = 0xadbac7
      quote-block-color = 0x444c56
      link-color = 0x539bf5
      # select-color
      # checkbox-color

      code-highlighter = "dracula"

      [keybindings]
      extra = [
        ["ZoomIn", "="],
        ["ZoomOut", "-"],
        ["ZoomReset", "0"],
      ]
    '';
}
