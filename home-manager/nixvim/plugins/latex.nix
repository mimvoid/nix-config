{ pkgs, ... }:

{
  programs.nixvim.plugins.vimtex = {
    enable = true;

    # Can provide more packages through nix develop
    texlivePackage = pkgs.texliveMinimal;

    settings = {
      view_method = "zathura";
    };
  };
}
