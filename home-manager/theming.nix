{ config, pkgs, ... }:

{
    home.packages = with pkgs; [
        # Icons
        catppuccin-papirus-folders

        # Fonts
        (nerdfonts.override { fonts = [ "SourceCodePro" ]; })
        cantarell-fonts
    ];

    fonts.fontconfig = {
        enable = true;
        defaultFonts = {
            serif = config.fonts.fontconfig.defaultFonts.sansSerif;
            sansSerif = [ "Cantarell" ];
            monospace = [ "SauceCodePro Nerd Font" ];
        };
    };

    gtk = {
        enable = true;
        font = {
            name = "Cantarell";
            package = pkgs.cantarell-fonts;
        };
        cursorTheme = {
            name = "BreezeX-RosePineDawn-Linux";
            package = pkgs.rose-pine-cursor;
            size = 24;
        };
        iconTheme = {
            name = "Papirus";
            package = pkgs.catppuccin-papirus-folders;
        };
        theme = {
            name = "rose-pine-moon";
            package = pkgs.rose-pine-gtk-theme;
        };
    };

    qt = {
        enable = true;
        platformTheme = "gtk";
        style.name = "breeze";
    };
}
