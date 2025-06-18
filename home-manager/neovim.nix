{ pkgs, inputs, ... }:
let
  # Get nixPatch Neovim from inputs
  nvim = inputs.nvim.packages.${pkgs.system}.default;

  # Copy and override the Neovim desktop entry
  nvim-kitty-desktop =
    let
      inherit (pkgs.lib) hiPrio;
      inherit (pkgs) writeTextFile;
      inherit (builtins) replaceStrings readFile;
      desktop-file-validate = "${pkgs.buildPackages.desktop-file-utils}/bin/desktop-file-validate";
    in
    hiPrio (
      writeTextFile {
        name = "nvim.desktop";
        destination = "/share/applications/nvim.desktop";

        # Change terminal & exec settings to launch with kitty
        text = replaceStrings
          [ "Terminal=true" "Exec=nvim %F" ]
          [ "Terminal=false" "Exec=kitty nvim %F" ]
          (readFile "${nvim}/share/applications/nvim.desktop");

        checkPhase = ''${desktop-file-validate} "$target"'';
      }
    );
in
{
  home.packages = [
    nvim
    nvim-kitty-desktop
  ];

  # Make default editor
  home.sessionVariables.EDITOR = "nvim";
}
