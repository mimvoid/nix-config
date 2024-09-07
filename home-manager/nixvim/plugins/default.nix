{ pkgs, ... }:
let
  r-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "R.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "R-nvim";
      repo = "R.nvim";
      rev = "0acf1fc99a504cf45f3b91dd9ec9394ec73f33fe";
      hash = "sha256-FHjjae4QhohHeZQIzCvZZ3SoP3oxrNm9g6kjYMc0AAo=";
    };
  };
in
{
  imports = [
    ./alpha.nix
    ./bufferline.nix
    ./completion.nix
    ./conform.nix
    ./dap.nix
    ./lsp.nix
    ./lualine.nix
    ./markdown.nix
    ./mini.nix
    ./neo-tree.nix
    ./nvim-colorizer.nix
    ./telescope.nix
    ./todo.nix
    ./treesitter.nix
    ./trouble.nix
  ];

  programs.nixvim = {
    plugins = {
      nvim-autopairs.enable = true;
      persistence.enable = true;
      marks.enable = true;
    };

    extraPlugins = with pkgs.vimPlugins; [
      plenary-nvim
      fcitx-vim
    ] ++ [ r-nvim ];

    extraPackages = with pkgs; [
      fzf
      ripgrep
    ];
  };
}
