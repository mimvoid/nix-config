{ config, pkgs, inputs, lib, ... }: 

# Stylix works well in the terminal
# but has some issues outside it so
# auto-enable is off

{
    stylix = {
        autoEnable = false;

        image = ../wallpapers/airy_scenery.jpg;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine-moon.yaml";

        fonts = {
            serif = config.stylix.fonts.sansSerif;
            sansSerif = {
                package = pkgs.cantarell-fonts;
                name = "Cantarell";
            };
            monospace = {
                package = (pkgs.nerdfonts.override { fonts = [ "SourceCodePro" ];});
                name = "SauceCodePro NFM";
            };
            sizes.terminal = 14;
        };

        cursor = {
            name = lib.mkDefault "BreezeX-RosePineDawn-Linux";
            package = lib.mkDefault pkgs.rose-pine-cursor;
            size = lib.mkDefault 24;
        };

        opacity.popups = 0.95;
        opacity.terminal = 0.85;
    };

    stylix.targets = {
        bat.enable = true;
        foot.enable = true;
        fzf.enable = true;
        nixvim = {
            enable = true;
            transparent_bg.main = false;
            transparent_bg.sign_column = false;
        };
        yazi.enable = true;
    };
}
