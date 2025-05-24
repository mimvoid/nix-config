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

  catppuccin-fcitx5 = prev.catppuccin-fcitx5.overrideAttrs (finalAttrs: prevAttrs: {
    installPhase = ''
      runHook preInstall
      mkdir -p $out/share/fcitx5/themes
      cp -r src/catppuccin-macchiato-pink $out/share/fcitx5/themes/catppuccin-macchiato-pink
      runHook postInstall
    '';
  });
}
