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

  nvim-project-marks = pkgs.vimUtils.buildVimPlugin {
    name = "nvim-project-marks";
    src = pkgs.fetchFromGitHub {
      owner = "BartSte";
      repo = "nvim-project-marks";
      rev = "0.2.0";
      hash = "sha256-/LC/URb4sEURa7S9Ht20k9eTbJ3tZCvkHRwcxlBfra0=";
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
    ./completion.nix
    ./conform.nix
    ./lsp.nix
    ./lualine.nix
    ./markdown.nix
    ./mini.nix
    ./nvim-colorizer.nix
    ./telescope.nix
    ./treesitter.nix
  ];

  programs.nixvim = {
    plugins = {
      nvim-autopairs.enable = true;
      persistence.enable = true;
      marks.enable = true;
    };

    extraPlugins = with pkgs.vimPlugins; [
      plenary-nvim
      tabout-nvim
      fcitx-vim
    ] ++ [
      r-nvim
      nvim-project-marks
      neotab-nvim
    ];

    # neotab.nvim config
    extraConfigLua = # lua
    ''
      require("projectmarks").setup({})

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
