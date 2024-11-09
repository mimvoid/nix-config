{ pkgs, ... }:

{
  imports = [
    ./colorscheme.nix
    ./opts.nix
    ./keymaps.nix
    ./plugins
  ];

  programs.nixvim = {
    enable = true;
    package = pkgs.unstable.neovim-unwrapped;
    defaultEditor = true;
    enableMan = false;
  };
}
