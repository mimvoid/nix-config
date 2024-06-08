{ pkgs, ... }:

{
  imports = [
    ./alpha.nix
    ./arrow.nix
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
    ./which-key.nix
  ];

  programs.nixvim = {
    plugins = {
      better-escape = {
        enable = true;
        mapping = [ "fj" ];
        timeout = 500;
      };
      endwise.enable = true;
      nvim-autopairs.enable = true;
      nvim-colorizer.enable = true;
      persistence.enable = true;
    };
    extraPlugins = with pkgs.vimPlugins; [
      yuck-vim
    ];
  };
}
