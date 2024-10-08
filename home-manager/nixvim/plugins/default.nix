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
    ./lsp.nix
    ./lualine.nix
    ./marks.nix
    ./mini.nix
    ./telescope.nix
    ./treesitter.nix
  ];

  programs.nixvim = {
    plugins = {
      nvim-autopairs.enable = true;
      persistence.enable = true;
    };

    extraPlugins = with pkgs.vimPlugins; [
      plenary-nvim
      tabout-nvim
      fcitx-vim
    ] ++ [
      r-nvim
      neotab-nvim
    ];

    # neotab.nvim config
    extraConfigLua = # lua
    ''
      require("neotab").setup({
        tabkey = "",
        smart_punctuators = {
          enabled = true,
          semicolon = {
            enabled = true,
            ft = { "nix", "javascript", "typescript" },
          },
        },
      })
    '';
    plugins.cmp.settings.mapping."<Tab>" = # lua
    ''
      cmp.mapping(function()
        if cmp.visible() then
          cmp.select_next_item()
        else
          require("neotab").tabout()
        end
      end)
    '';

    extraPackages = with pkgs; [
      fzf
      ripgrep
    ];
  };
}
