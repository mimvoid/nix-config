{ pkgs, ... }:

{
  imports = [
    ./colorscheme.nix
    ./opts.nix
    ./keymaps.nix
    ./plugins/default.nix
  ];

  programs.nixvim = {
    enable = true;
    package = pkgs.unstable.neovim-unwrapped;
    defaultEditor = true;
    type = "lua";
    enableMan = false;
  };
}
