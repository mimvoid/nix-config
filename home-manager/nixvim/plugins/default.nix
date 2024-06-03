{ ... }:

{
  imports = [
    ./alpha.nix
    ./bufferline.nix
    #./cmp.nix
    #./lint.nix
    ./lsp.nix
    ./neo-tree.nix
    ./telescope.nix
    ./treesitter.nix
    #./which-key.nix
  ];

  programs.nixvim.plugins = {
    lazy.enable = true;

    ccc.enable = true;
    cmp.enable = true;

    lint.enable = true;
    nvim-autopairs.enable = true;
  };
}
