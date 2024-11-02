{ pkgs, ... }:
let
  neotab-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "neotab.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "kawre";
      repo = "neotab.nvim";
      rev = "6c6107dddaa051504e433608f59eca606138269b";
      hash = "sha256-bSFKbjj8fJHdfBzYoQ9l3NU0GAYfdfCbESKbwdbLNSw=";
    };
  };
in
{
  imports = [
    ./alpha.nix
    ./bufferline.nix
    ./colors.nix
    ./completion.nix
    ./conform.nix
    ./latex.nix
    ./lsp.nix
    ./lualine.nix
    ./marks.nix
    ./mini.nix
    ./r.nix
    ./snippets.nix
    ./telescope.nix
    ./treesitter.nix
  ];
  programs.nixvim = {
    plugins = {
      persistence.enable = true;
      web-devicons.enable = true;
    };

    extraPlugins = with pkgs.vimPlugins; [
      plenary-nvim
      fcitx-vim
      ultimate-autopair-nvim
      neotab-nvim
    ];

    # neotab.nvim config
    extraConfigLua = # lua
    ''
      require("ultimate-autopair").setup({})
      require("neotab").setup({
        smart_punctuators = {
          enabled = true,
          semicolon = {
            enabled = true,
            ft = { "nix", "javascript", "typescript" },
          },
        },
      })
    '';

    extraPackages = with pkgs; [
      fzf
      ripgrep
    ];
  };
}
