{ pkgs, ... }:

{
  imports = [
    ./opts.nix
    ./keymaps.nix
    ./plugins/default.nix
  ];

  home.packages = with pkgs [
    ripgrep
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    type = "lua";
    extraPlugins = with pkgs.vimPlugins = [
      plenary-nvim
    ];
  };
}
