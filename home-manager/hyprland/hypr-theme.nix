{ config, lib, ... }:

let
    homescreen = "~/NixOS/wallpapers/Manga-Girl-Rain.png";
    lockscreen = "~/NixOS/wallpapers/Buildings.png";

    hue = config.colorScheme.palette;
    type = config.stylix.fonts;
    display = "Limelight";
in
{
    imports = [
        ../theming.nix
        ../../palettes/macchiato-nightlight.nix
    ];

    wayland.windowManager.hyprland.settings = {
        # Homescreen wallpaper
        exec = lib.mkAfter [ "swaybg -i ${homescreen}" ];
        general = {
            "col.active_border" = "rgb(${hue.mainAccent})";
            "col.inactive_border" = "rgb(${hue.dullAccent})";
        };
        decoration."col.shadow" = "rgb(${hue.etch})";
    };

    programs.hyprlock.settings = {
        # Lockscreen wallpaper
        background = [{ path = lockscreen; }];
        input-field = [{
                outer_color = "rgb(${hue.watch})";
                inner_color = "rgb(${hue.base})";
        }];
    };

    programs.fuzzel.settings = {
        main = {
            font = "${type.monospace.name}:size=9";
        };
        colors = {
            background = "${hue.base}ee";
            text = "${hue.text}ff";
            match = "${hue.mainAccent}ff";
            selection = "${hue.frame}dd";
            selection-match = "${hue.secAccent}ff";
            selection-text = "${hue.paleAccent}ff";
            border = "${hue.watch}ff";
        };
    };
    
    services.mako = {
        font = "${type.monospace.name} Medium 9";
        backgroundColor = "#${hue.base}bb";
        textColor = "#${hue.text}";
        borderColor = "#${hue.secAccent}";
        progressColor = "over #${hue.edge}";
    };
}
