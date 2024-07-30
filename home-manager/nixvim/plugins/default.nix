{
  imports = [
    ./alpha.nix
    ./bufferline.nix
    ./completion.nix
    ./git.nix
    ./lsp.nix
    ./lualine.nix
    ./markdown.nix
    ./neo-tree.nix
    ./nvim-colorizer.nix
    ./telescope.nix
    ./todo.nix
    ./treesitter.nix
    ./trouble.nix
  ];

  programs.nixvim.plugins = {
    nvim-autopairs.enable = true;
    persistence.enable = true;
  };
}
