{ config, ... }:

{
  xdg.configFile."dooit/colors.py".text =
    with config.lib.stylix.colors.withHashtag; # python
      ''
        from dooit.api.theme import DooitThemeBase

        class MoonflowerDusk(DooitThemeBase):
            _name = "moonflower-dusk"

            background1: str = "${base00}"
            background2: str = "${base01}"
            background3: str = "${base02}"

            foreground1: str = "${base03}"
            foreground2: str = "${base04}"
            foreground3: str = "${base05}"

            red: str = "${red}"
            orange: str = "${yellow}"
            yellow: str = "${yellow}"
            green: str = "${green}"
            blue: str = "${blue}"
            purple: str = "${magenta}"
            magenta: str = "${magenta}"
            cyan: str = "${cyan}"

            primary: str = yellow
            secondary: str = green
      '';
}
