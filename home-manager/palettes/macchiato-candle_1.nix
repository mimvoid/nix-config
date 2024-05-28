# Macchiato Candle palette & fonts
# Custom catppuccin macchiato with rosy accents and cool bases

# Resulting package name is pkgs.candle?
# Default format is ffffff, use nix-rice to translate it?

#self: super: with super.lib.nix-rice;
let
    theme = ./raw-palettes/catppuccin-macchiato.nix
in
{
    candle.colorPalette = rec {
        main = palette.defaultPalette // {
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
        };
    } // theme;
    candle.fonts = {
        sansSerif = {
            name = "Cantarell";
            package = self.cantarell-fonts;
        };
        monospace = {
            name = "SauceCodePro NFM";
            package = self.nerdfonts.override { fonts = [ "SourceCodePro" ]; };
        };
    };
}
