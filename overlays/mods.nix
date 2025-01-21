{ final, prev, ... }:
let
  # Meaning: pkgs = final.pkgs;
  inherit (final) pkgs; 
in
{
  # Add extra packages to dooit
  dooit = final.dooit.override {
    extraPackages = with pkgs; [
      dooit-extras
    ];
  };

  # Pink Catppuccin Macchiato Papirus folders
  catppuccin-papirus-folders = prev.catppuccin-papirus-folders.override {
    flavor = "macchiato";
    accent = "pink";
  };
}
