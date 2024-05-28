{ config, pkgs, ... }:

{
    home.packages = with pkgs; [
        # Icons
        papirus-icon-theme
        catppuccin-papirus-folders

        # Fonts
        (nerdfonts.override { fonts = [ "SourceCodePro" ]; };)
        cantarell-fonts
        (noto-fonts-lgc-plus.override { variants = [ "Noto Sans" ];};)
    ];

    fonts.fontconfig = {
        enable = true;
        defaultFonts = {
            serif = config.fonts.fontconfig.defaultFonts.sansSerif;
            sansSerif = [ "Cantarell" "Noto Sans" ];
            monospace = "SauceCodePro Nerd Font";
        };
    };

    home.pointerCursor = {
        name = "BreezeX-RosePineDawn-Linux";
        package = pkgs.rose-pine-cursor;
        size = 24;
        gtk.enable = true;
    }

    gtk = {
        enable = true;
        font = {
            name = "Cantarell";
            package = pkgs.cantarell-fonts;
        };
        iconTheme = {
            name = "Papirus";
            package = pkgs.papirus-icon-theme;
        };
    };

    qt = {
        enable = true;
        platformTheme = "kde";
        style.name = "breeze";
    };
}
