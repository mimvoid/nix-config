{ pkgs, lib, ... }:

{
    home.packages = with pkgs; [
        # Icons
        catppuccin-papirus-folders
        rose-pine-cursor

        # Fonts
        # Sans serif
        cantarell-fonts
        noto-fonts-cjk-sans
        atkinson-hyperlegible
        raleway
        carlito

        # Serif
        noto-fonts-cjk-serif

        # Monospace
        (nerdfonts.override { fonts = [ "SourceCodePro" ]; })
        courier-prime

        # Display / Handwriting
        (google-fonts.override { fonts = [ "Limelight-Regular" "Oswald[wght]" "MajorMonoDisplay-Regular" "MaShanZheng-Regular" ]; })
        norwester-font
        lxgw-wenkai
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
