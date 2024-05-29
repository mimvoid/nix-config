{ config, pkgs, lib, ... }:

{
    home.packages = with pkgs; [
        # Icons
        catppuccin-papirus-folders
        rose-pine-cursor

        # Fonts
        (nerdfonts.override { fonts = [ "SourceCodePro" ]; })
        cantarell-fonts
    ];

    gtk = {
        enable = true;
        font = {
            name = lib.mkForce "Cantarell";
            package = lib.mkForce pkgs.cantarell-fonts;
        };
        cursorTheme = {
            name = lib.mkForce "BreezeX-RosePineDawn-Linux";
            package = lib.mkForce pkgs.rose-pine-cursor;
            size = lib.mkForce 24;
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
        platformTheme = "kde";
        style.name = "breeze";
    };
}
