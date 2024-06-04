# Template for new color palettes using nix-rice
# I only transform it when needed, so there's just main here for now
# Commented the head since I think it applies as an overlay automatically otherwise?

# self: super: with super.lib.nix-rice;
let
    theme = ./path/to/theme.nix
in
{
    colorPaletteName.colorPalette = rec {
        main = palette.defaultPalette // {
            # Bases: neutral colors, most common
            text = theme.text;
            base = theme.base;
            line = theme.surface0; # Either a bit lighter or darker than base
            frame = theme.surface1; # Lighter or darker than line

            # Accents: colorful parts of the palette
            accent-main = theme.flamingo;
            accent-pair = theme.pink; # Goes well with accent-main
            accent-mid = theme.mauve; # Dullest, but more vibrant than bases

            watch = theme.yellow; # Differs from the above accents, easily noticeable
            alert = theme.maroon; # The most eye-catching accent in the palette            
        }; // theme;
        font = {
            sansSerif = {
                name = "Cantarell";
                package = self.cantarell-fonts;
            };
            monospace = {
                name = "SauceCodePro NFM";
                package = self.nerdfonts.override { fonts = [ "SourceCodePro" ]; };
            };
        };
    };
}
