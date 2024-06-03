{ ... }:

{
  imports = [
    ./nixvim.nix
    #./keymaps.nix
    ./plugins.nix
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
  };
}
