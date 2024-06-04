{
  imports = [
    ./alpha.nix
    ./arrow.nix
    ./bufferline.nix
    #./cmp.nix
    ./lsp.nix
    ./neo-tree.nix
    ./telescope.nix
    ./treesitter.nix
    #./which-key.nix
  ];

  programs.nixvim.plugins = {
    cmp.enable = true;
    nvim-autopairs.enable = true;
  };
}
