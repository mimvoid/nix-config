{ config, lib, inputs, ... }:

let
    homescreen = "~/NixOS/wallpapers/Manga-Girl-Rain.png";
    lockscreen = "~/NixOS/wallpapers/Buildings.png";
    current-palette = ../../palettes/macchiato-nightlight.nix;
    display = "Limelight";

    hue = config.colorScheme.palette;
    type = config.stylix.fonts;
in
{
    imports = [
        ../theming.nix
        inputs.nix-colors.homeManagerModules.default
        current-palette
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
