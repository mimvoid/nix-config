{ final, _prev, ... }:
let
  inherit (final) pkgs;
in
{
  # Add extra packages to dooit
  dooit = final.dooit.override {
    extraPackages = with pkgs; [
      dooit-extras
    ];
  };

  # Hasklug nerd font
  nerdfonts = _prev.nerdfonts.override {
    fonts = [ "Hasklig" ];
  };

  # Pink Catppuccin Macchiato Papirus folders
  catppuccin-papirus-folders = _prev.catppuccin-papirus-folders.override {
    flavor = "macchiato";
    accent = "pink";
  };
}
