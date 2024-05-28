# Macchiato Candle palette & fonts
# Custom catppuccin macchiato with rosy accents and cool bases

# Default format is ffffff, use nix-rice to translate it?

{ config, ... }:

let
    theme = ./raw-palettes/catppuccin-macchiato.nix
in
{
    # Color palette
    # Bases: neutral colors, most common
    text = theme.text;
    base = theme.base;
    line = theme.surface0;
    frame = theme.surface1;

    # Accents: colorful parts of the palette
    accent-main = theme.flamingo;
    accent-pair = theme.pink;
    accent-mid = theme.mauve;

    watch = theme.yellow;
    alert = theme.maroon;
    
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
