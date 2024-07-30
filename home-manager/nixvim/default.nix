{
  imports = [
    ./colorscheme.nix
    ./opts.nix
    ./keymaps.nix
    ./plugins/default.nix
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    type = "lua";
  };
}
