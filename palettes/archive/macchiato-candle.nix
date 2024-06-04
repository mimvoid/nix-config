# Macchiato Candle palette & fonts
# Custom catppuccin macchiato with rosy accents and cool bases

# This is ridiculous, needs to have some abstraction or I will tire

{ config, ... }:

{
    imports = [ ./raw-palettes/catppuccin-macchiato.nix ];

    # Bases: neutral colors, most common
    text = {
        hex = text.hex;
        rgb = text.rgb;
    };
    base = {
        hex = base.hex;
        rgb = base.rgb;
    };
    line = {
        hex = surface0.hex;
        rgb = surface0.rgb;
    };
    frame = {
        hex = surface1.hex;
        rgb = surface0.rgb;
    };

    # Accents: colorful parts of the palette
    accent-main = {
        hex = flamingo.hex;
        rgb = flamingo.rgb;
    };
    accent-pair = {
        hex = pink.hex;
        rgb = pink.rgb;
    };
    accent-mid = {
        hex = mauve.hex;
        rgb = mauve.rgb;
    };

    watch = {
        hex = yellow.hex;
        rgb = yellow.rgb;
    };
    alert = {
        hex = maroon.hex;
        rgb = maroon.rgb;
    };
    
    # Fonts
    sansSerif = {
        name = "Cantarell";
        package = pkgs.cantarell-fonts;
    };
    monospace = {
        name = "SauceCodePro NFM";
        package = self.nerdfonts.override { fonts = [ "SourceCodePro" ]; };
    };
}
