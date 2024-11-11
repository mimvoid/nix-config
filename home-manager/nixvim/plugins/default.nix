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
    ./lz-n.nix
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
    # and disable default plugins
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

        local disabled_built_ins = {
          "netrw",
          "netrwPlugin",
          "netrwSettings",
          "netrwFileHandlers",
          "gzip",
          "zip",
          "zipPlugin",
          "tar",
          "tarPlugin",
          "getscript",
          "getscriptPlugin",
          "vimball",
          "vimballPlugin",
          "2html_plugin",
          "logipat",
          "rrhelper",
          "spellfile_plugin",
          "matchit",
          "tutor_mode_plugin"
        }

        for _, plugin in pairs(disabled_built_ins) do
            vim.g["loaded_" .. plugin] = 1
        end
      '';

    extraPackages = with pkgs; [
      fzf
      ripgrep
    ];
  };
}
