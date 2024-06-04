{ pkgs, ... }:

{
  imports = [
    ./opts.nix
    ./keymaps.nix
    ./plugins/default.nix
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    type = "lua";
    extraPackages = with pkgs; [
      fzf
      ripgrep
    ];
    extraPlugins = with pkgs.vimPlugins; [
      plenary-nvim
    ];
  };
}
